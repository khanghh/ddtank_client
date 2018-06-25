package totem.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import totem.HonorUpManager;
   import totem.data.HonorUpDataVo;
   
   public class HonorUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _btnBg:Bitmap;
      
      private var _tip1:FilterFrameText;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _selecteItem:DoubleSelectedItem;
      
      public function HonorUpFrame()
      {
         super();
         initView();
         initEvent();
         refreshShow(null);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.totem.honorUpFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatBitmap("asset.totem.honorUpFrame.mainBg");
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.totem.honorUpFrame.btnBg");
         _tip1 = ComponentFactory.Instance.creatComponentByStylename("totem.honorUpFrame.tip1");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("totem.honorUpFrame.upBtn");
         addToContent(_bg);
         addToContent(_btnBg);
         _selecteItem = new DoubleSelectedItem();
         _selecteItem.x = 154;
         _selecteItem.y = 292;
         addToContent(_selecteItem);
         addToContent(_tip1);
         addToContent(_upBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _upBtn.addEventListener("click",doUpHonor,false,0,true);
         HonorUpManager.instance.addEventListener("up_count_update",refreshShow,false,0,true);
      }
      
      private function refreshShow(event:Event) : void
      {
         var data:* = null;
         var dataList:Array = HonorUpManager.instance.dataList;
         var upCount:int = HonorUpManager.instance.upCount;
         if(upCount >= dataList.length)
         {
            dispose();
         }
         else
         {
            data = dataList[upCount] as HonorUpDataVo;
            _tip1.htmlText = LanguageMgr.GetTranslation("ddt.totem.honorUpFrame.tip1",data.money,data.honor);
         }
      }
      
      private function doUpHonor(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var dataList:Array = HonorUpManager.instance.dataList;
         var upCount:int = HonorUpManager.instance.upCount;
         var money:int = (dataList[upCount] as HonorUpDataVo).money;
         CheckMoneyUtils.instance.checkMoney(_selecteItem.isBind,money,onCheckComplete);
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendHonorUp(2,CheckMoneyUtils.instance.isBind);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _upBtn.removeEventListener("click",doUpHonor);
         HonorUpManager.instance.removeEventListener("up_count_update",refreshShow);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selecteItem);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btnBg);
         _btnBg = null;
         ObjectUtils.disposeObject(_tip1);
         _tip1 = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         super.dispose();
      }
   }
}
