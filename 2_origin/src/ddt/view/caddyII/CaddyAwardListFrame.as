package ddt.view.caddyII
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.items.AwardListItem;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class CaddyAwardListFrame extends Frame implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _btn:TextButton;
      
      private var _list:VBox;
      
      private var _listArray:Vector.<AwardListItem>;
      
      private var _titleBitmap:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _Vline:MutipleImage;
      
      private var _descripTxt1:FilterFrameText;
      
      private var _descripTxt2:FilterFrameText;
      
      private var _descripTxt3:FilterFrameText;
      
      private var sortTitleTxt:FilterFrameText;
      
      private var NametitleTxt:FilterFrameText;
      
      private var NumbertitleTxt:FilterFrameText;
      
      private var _dataList:Object;
      
      public function CaddyAwardListFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         titleText = "奖励兑换";
         _bg = ComponentFactory.Instance.creatBitmap("asset.caddy.goods.bigBack");
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc2_.x = 159;
         _loc2_.y = 123;
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc4_.x = 323;
         _loc4_.y = 123;
         sortTitleTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.paiTxt");
         sortTitleTxt.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.sortTitletxt");
         NametitleTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.nameTxt");
         NametitleTxt.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.nameTitletxt");
         NametitleTxt.x = 220;
         NumbertitleTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.goodsTxt");
         NumbertitleTxt.text = LanguageMgr.GetTranslation("caddy.badLuck.propertyText.text");
         NumbertitleTxt.x = 438;
         _descripTxt1 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.goodsTxt");
         _descripTxt1.text = LanguageMgr.GetTranslation("caddy.badLuck.regulationText6.text");
         _descripTxt1.x = 40;
         _descripTxt1.y = 94;
         _descripTxt2 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.goodsTxt");
         _descripTxt2.text = LanguageMgr.GetTranslation("caddy.badLuck.regulationText7.text");
         _descripTxt2.x = 39;
         _descripTxt2.y = 342;
         _descripTxt3 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.goodsTxt");
         _descripTxt3.text = LanguageMgr.GetTranslation("caddy.badLuck.regulationText1.text") + "\n" + LanguageMgr.GetTranslation("caddy.badLuck.regulationText2.text") + "\n" + LanguageMgr.GetTranslation("caddy.badLuck.regulationText3.text") + "\n" + LanguageMgr.GetTranslation("caddy.badLuck.regulationText4.text") + "\n" + LanguageMgr.GetTranslation("caddy.badLuck.regulationText5.text");
         _descripTxt3.x = 54;
         _descripTxt3.y = 380;
         _listArray = new Vector.<AwardListItem>();
         _titleBitmap = ComponentFactory.Instance.creatBitmap("asset.caddy.titlle");
         _list = ComponentFactory.Instance.creatComponentByStylename("caddy.luckpaihangBox");
         _btn = ComponentFactory.Instance.creatComponentByStylename("caddy.btn1");
         _btn.text = "O K";
         _btn.addEventListener("click",clickHander);
         _panel = ComponentFactory.Instance.creatComponentByStylename("caddy.LuckpaihangScrollpanel");
         _panel.setView(_list);
         _loc3_ = 1;
         while(_loc3_ < 11)
         {
            _loc1_ = new AwardListItem();
            _loc1_.initView("虚位以待" + _loc3_,"物品" + _loc3_,"url" + _loc3_,_loc3_);
            _loc1_.y = _loc3_ * 25;
            _list.addChild(_loc1_);
            _listArray.push(_loc1_);
            _loc3_++;
         }
         _panel.invalidateViewport();
         addToContent(_bg);
         addToContent(sortTitleTxt);
         addToContent(NametitleTxt);
         addToContent(NumbertitleTxt);
         addToContent(_descripTxt1);
         addToContent(_descripTxt2);
         addToContent(_descripTxt3);
         addToContent(_titleBitmap);
         addToContent(_panel);
         addToContent(_btn);
         addToContent(_loc2_);
         addToContent(_loc4_);
         addEventListener("response",_response);
         RouletteManager.instance.addEventListener("luckstone_rank_limit",getBadLuckHandler);
         SocketManager.Instance.out.sendQequestLuckky();
      }
      
      private function getBadLuckHandler(param1:CaddyEvent) : void
      {
         _dataList = param1.dataList;
         updateData();
      }
      
      private function updateData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 10 && _loc2_ < _dataList.length)
         {
            _loc1_ = _dataList[_loc2_];
            _listArray[_loc2_].upDataUserName(_loc1_);
            _loc2_++;
         }
      }
      
      private function clickHander(param1:MouseEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function upDataUserName() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 10;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _listArray[_loc2_].upDataUserName("asdasd");
            _loc2_++;
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      override public function dispose() : void
      {
         RouletteManager.instance.removeEventListener("luckstone_rank_limit",getBadLuckHandler);
         removeEventListener("response",_response);
         if(_btn)
         {
            _btn.removeEventListener("click",clickHander);
         }
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(_btn)
         {
            ObjectUtils.disposeObject(_btn);
         }
         _btn = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(sortTitleTxt)
         {
            ObjectUtils.disposeObject(sortTitleTxt);
         }
         sortTitleTxt = null;
         if(NametitleTxt)
         {
            ObjectUtils.disposeObject(NametitleTxt);
         }
         NametitleTxt = null;
         if(NumbertitleTxt)
         {
            ObjectUtils.disposeObject(NumbertitleTxt);
         }
         NumbertitleTxt = null;
         if(_descripTxt1)
         {
            ObjectUtils.disposeObject(_descripTxt1);
         }
         _descripTxt1 = null;
         if(_descripTxt2)
         {
            ObjectUtils.disposeObject(_descripTxt2);
         }
         _descripTxt2 = null;
         if(_descripTxt3)
         {
            ObjectUtils.disposeObject(_descripTxt3);
         }
         _descripTxt3 = null;
         if(_titleBitmap)
         {
            ObjectUtils.disposeObject(_titleBitmap);
         }
         _titleBitmap = null;
         if(_Vline)
         {
            ObjectUtils.disposeObject(_Vline);
         }
         _Vline = null;
      }
   }
}
