const serviceUrl= 'http://v.jspang.com:8088/baixing/';
//const serviceUrl= 'http://test.baixingliangfan.cn/baixing/';
const baseUrl = 'http://47.101.180.71:8080/';
//const baseUrl = 'http://10.211.55.6:8080/';
const servicePath={
  'homePageContext': serviceUrl+'wxmini/homePageContent', // 商家首页信息
  'homePageContext1': baseUrl + "homepage", // 商家首页信息
  'homePageBelowConten': serviceUrl+'wxmini/homePageBelowConten', //商城首页热卖商品拉取
  'getCategory': serviceUrl+'wxmini/getCategory', //商品类别信息
  'getCategory1': baseUrl + 'getCategory',
  'getMallGoods': serviceUrl+'wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailById':serviceUrl+'wxmini/getGoodDetailById', //商品详细信息列表
};

