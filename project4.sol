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
    
     //買賣結構
    struct buyInfo{
        uint buy_type;
        string buy_type_str;
        uint buy_num;
        uint buy_total_price;
        string my_address;
        bool if_buy_successfully;
    }
    
    //品項和價格
    string [5] public each_product = ['香瓜','胡瓜','芝麻','紅豆','胡蘿蔔'];
    uint [5] public each_price = [30,25,50,20,50];
    
    //合約提供者跟農夫買
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
    
    buyInfo public Customer;
    uint [5] public c_each_buy_num;
    
    function buy_from_contract(uint  product_type, uint  buy_numbers, string memory your_address) public {
        //delivery_successfully = false;
        Delivery.if_deliver_successfully =false;
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
                
                Customer.buy_type = product_type;
                Customer.buy_type_str = each_product[product_type];
                Customer.buy_num = buy_numbers;
                Customer.buy_total_price = each_price[product_type] * buy_numbers;
                c_each_buy_num[product_type] += buy_numbers;
                Customer.my_address= your_address;
                Customer.if_buy_successfully = true;
                
                m_each_buy_num[product_type] = m_each_buy_num[product_type] - c_each_buy_num[product_type];
                
                deliver(Customer.buy_type_str,Customer.buy_num,Customer.buy_total_price,Customer.my_address);
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
    
   
    //寄送結構
    struct deliverInfo{
        string deliver_type_str;
        uint deliver_num;
        uint deliver_total_price;
        string deliver_address;
        bool if_deliver_successfully;
    }
    
    //農夫送給消費者
    deliverInfo public Delivery;
    
    /*
    bool public delivery_successfully;
    string public d_type;
    uint public d_number;
    uint d_total_price;
    string public d_address;
    */
    
    function deliver(string memory _d_type,uint _d_number, uint _d_total_price,  string memory _d_address) private{
        
        Delivery.deliver_type_str = _d_type;
        Delivery.deliver_num = _d_number;
        Delivery.deliver_total_price = _d_total_price;
        Delivery.deliver_address = _d_address;
        Delivery.if_deliver_successfully = true;
        
        
        //delivery_successfully = true;
        //d_type = _d_type;
       // d_number = _d_number;
        //d_total_price = _d_total_price;
        //d_address = _d_address;
    }
    
}