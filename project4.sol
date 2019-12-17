pragma solidity ^0.5.0;

contract Delicate_Agriculture {
    
    
    constructor() public {
    }

    //random
    uint nonce = 100;
    function random() private returns (uint) {
        uint randomnumber = uint(keccak256(abi.encodePacked(nonce)));
        nonce = nonce + 3;
        return randomnumber;
    }
    
    
    
    //感測土壤農藥殘留
    uint public soil_pesticide;
    function sensor() private returns (bool){
        soil_pesticide = random() % 5;
        if(soil_pesticide < 2){
            return true;
        }else{
            return false;
        }
    }
    
    //驗證產品農藥殘留
    uint public product_pesticide;
    function product_verify() private returns (bool){
        product_pesticide = random() % 5;
        if(product_pesticide < 3){
            return true;
        }else{
            return false;
        }
    }
    
    
    
    
    struct buyInfo{
        uint buy_type;
        string buy_type_str;
        uint buy_num;
        uint buy_total_price;
        uint [5] each_productNum;
        string my_address;
        bool if_buy_successfully;
    }
    
    string [5] public each_product = ['香瓜','胡瓜','芝麻','紅豆','胡蘿蔔'];
    uint [5] public each_price = [30,25,50,20,50];
    
    //合約提供者跟農夫買
    //uint [5] public product_number = [0,0,0,0,0]; //貨源
    //uint public price_buy_from_faramer = 0; // 當前買的價格
    //bool public buy_successfully;
    
    //寫法2
    buyInfo public Manager;
    uint [5] public  m_each_buy_num;
    
    function buy_from_farmer(uint product_type, uint buy_numbers) public {
        Manager.if_buy_successfully = false; 
        
        if(product_type < 0 || product_type > 4){ //輸入品項超過
                //do nothing
        }
        else{
            bool soil_healthy = sensor();
            bool product_healthy = product_verify();
            if (soil_healthy&& product_healthy){ //土地和產品 驗證成功
                Manager.buy_type = product_type;
                Manager.buy_type_str = each_product[product_type];
                Manager.buy_num = buy_numbers;
                m_each_buy_num[product_type] += buy_numbers; //納入貨源
                Manager.buy_total_price= buy_numbers * each_price[product_type];
                Manager.if_buy_successfully = true;
            }
            else{ //驗證失敗 交易失敗
                //do nothing
            }
        }
    }
    
    
  
    
    
    
    //消費者跟合約提供者買
    
    /*
    string public customer_buy_type;//購買品項
    uint public customer_buy_number;//購買數量
    uint public customer_buy_totalPrice;//總額
    uint public customer_buy_price;//單價
    string public customer_address;//消費者地址
    bool public customer_buy_successfully;
    */
    
    buyInfo public Customer;
    uint [5] public c_each_buy_num;
    
    function buy_from_contract(uint  product_type, uint  buy_numbers, string memory your_address) public {
        delivery_successfully = false;
        //customer_buy_successfully = false;
        Customer.if_buy_successfully = false;
        if(product_type < 0 || product_type >4){
            Customer.buy_type = 0;
            Customer.buy_type_str = 'not exist';
            Customer.buy_num = 0;
            Customer.buy_total_price = 0;
           
            Customer.my_address= your_address;
            
                
            //do nothing
        }else{ //start buying
            if(buy_numbers <= m_each_buy_num[product_type]){//庫存夠 可以買
            /*
                customer_buy_successfully =true;
                customer_buy_type = each_product[product_type];//購買品項
                customer_buy_number = buy_numbers;//購買數量同步
                customer_buy_totalPrice = each_price[product_type] * buy_numbers;//總額同步
                customer_buy_price = each_price[product_type];//單價
                customer_address = your_address;//地址同步
             */   
                
                Customer.buy_type = product_type;
                Customer.buy_type_str = each_product[product_type];
                Customer.buy_num = buy_numbers;
                Customer.buy_total_price = each_price[product_type] * buy_numbers;
                c_each_buy_num[product_type] += buy_numbers;
                Customer.my_address= your_address;
                Customer.if_buy_successfully = true;
                
                m_each_buy_num[product_type] = m_each_buy_num[product_type] - c_each_buy_num[product_type];
                
                delivery(Customer.buy_type_str,Customer.buy_num,Customer.buy_total_price,Customer.my_address);
            }else{//消費者買的數量 > 庫存
                // do nothing
                Customer.buy_type = product_type;
                Customer.buy_type_str = each_product[product_type];
                Customer.buy_num = buy_numbers;
                Customer.buy_total_price = 0;
                Customer.my_address=your_address;
            }
            
        }
    }
    
    //農夫送給消費者
    bool public delivery_successfully;
    string public d_type;
    uint public d_number;
    uint d_total_price;
    string public d_address;
    function delivery(string memory _d_type,uint _d_number, uint _d_total_price,  string memory _d_address) private{
        delivery_successfully = true;
        d_type = _d_type;
        d_number = _d_number;
        d_total_price = _d_total_price;
        d_address = _d_address;
    }
    
}