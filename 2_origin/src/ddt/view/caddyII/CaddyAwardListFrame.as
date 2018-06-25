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
         var i:int = 0;
         var item:* = null;
         titleText = "奖励兑换";
         _bg = ComponentFactory.Instance.creatBitmap("asset.caddy.goods.bigBack");
         var line1:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line1.x = 159;
         line1.y = 123;
         var line2:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line2.x = 323;
         line2.y = 123;
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
         for(i = 1; i < 11; )
         {
            item = new AwardListItem();
            item.initView("虚位以待" + i,"物品" + i,"url" + i,i);
            item.y = i * 25;
            _list.addChild(item);
            _listArray.push(item);
            i++;
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
         addToContent(line1);
         addToContent(line2);
         addEventListener("response",_response);
         RouletteManager.instance.addEventListener("luckstone_rank_limit",getBadLuckHandler);
         SocketManager.Instance.out.sendQequestLuckky();
      }
      
      private function getBadLuckHandler(e:CaddyEvent) : void
      {
         _dataList = e.dataList;
         updateData();
      }
      
      private function updateData() : void
      {
         var i:int = 0;
         var obj:* = null;
         i = 0;
         while(i < 10 && i < _dataList.length)
         {
            obj = _dataList[i];
            _listArray[i].upDataUserName(obj);
            i++;
         }
      }
      
      private function clickHander(e:MouseEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function upDataUserName() : void
      {
         var i:int = 0;
         var len:int = 10;
         for(i = 0; i < len; )
         {
            _listArray[i].upDataUserName("asdasd");
            i++;
         }
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
