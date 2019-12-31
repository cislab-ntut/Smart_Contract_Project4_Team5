# Project5-4_Smart_contract
## 構思
近來對於有機的定義越來越模糊，於是如何驗證「有機」是個大問題。

---
### 概念:
1.  農夫先將產品交給農委會驗證
2.  在產地植入 sensor偵測農藥濃度
3.  合約提供者只購買通過1、2兩認證之農產品
4.  消費者跟合約提供者購買，由農夫直接寄送
5.  主要由合約提供者跟消費者進行銷售(類似團購的概念)
---
### 農產品驗證標準   : 殺蟲劑濃度< 0.3
### 土壤農藥殘留標準 : 殺蟲劑濃度< 0.2
---
### 產品項目
|   產品     |   價格(包)   | 
| --------  | ----------  | 
|   香瓜     |    30      |
|   胡瓜     |    25      | 
|   芝麻     |    50      | 
|   紅豆     |    20      | 
|  胡蘿蔔    |    50       |

---

### 架構圖
![](https://i.imgur.com/HxJpVr3.jpg)

---

## 操作步驟

1. 管理者向農夫購買產品
![](https://i.imgur.com/G61oMnv.jpg)
2. 確認是否購買完成
(失敗範例)
![](https://i.imgur.com/k0kJUkp.jpg)
(成功範例)
![](https://i.imgur.com/FF1JwEa.jpg)
3. 確認管理者的庫存
![](https://i.imgur.com/srnNxEY.jpg)
4. 消費者向管理者購買產品
![](https://i.imgur.com/S41SyYn.jpg)
5. 確認是否購買完成
![](https://i.imgur.com/Z7XK5C6.jpg)
6. 宅配
![](https://i.imgur.com/Nx9g7Ct.jpg)
