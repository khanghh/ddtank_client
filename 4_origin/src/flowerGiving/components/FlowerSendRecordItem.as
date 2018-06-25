package flowerGiving.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flowerGiving.FlowerGivingController;
   import flowerGiving.data.FlowerSendRecordInfo;
   import flowerGiving.events.FlowerSendRecordEvent;
   
   public class FlowerSendRecordItem extends Sprite implements Disposeable
   {
       
      
      private var _timeTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _huikuiBtn:SimpleBitmapButton;
      
      private var _sender:String;
      
      private var _num:int;
      
      private var _receiver:String;
      
      public function FlowerSendRecordItem(index:int)
      {
         super();
         initView();
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,490,index % 2 == 0?34:32);
         this.graphics.endFill();
         addEvent();
      }
      
      private function initView() : void
      {
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendRecordFrame.Txt");
         addChild(_timeTxt);
         PositionUtils.setPos(_timeTxt,"flowerGiving.flowerSendRecordFrame.timePos");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendRecordFrame.Txt");
         addChild(_contentTxt);
         PositionUtils.setPos(_contentTxt,"flowerGiving.flowerSendFrame.contentPos");
         _huikuiBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendRecordFrame.huiKuiBtn");
         addChild(_huikuiBtn);
      }
      
      public function setData(info:FlowerSendRecordInfo) : void
      {
         _num = info.num;
         if(info.flag)
         {
            _sender = "bạn";
            _receiver = info.nickName;
            _huikuiBtn.visible = false;
         }
         else
         {
            _sender = info.nickName;
            _receiver = "bạn";
            _huikuiBtn.visible = true;
         }
         _contentTxt.htmlText = LanguageMgr.GetTranslation("flowerGiving.flowerSendRecordFrame.contentTxt",_sender,_num,_receiver);
         _timeTxt.text = info.date;
      }
      
      private function addEvent() : void
      {
         _huikuiBtn.addEventListener("click",__huikuiClick);
      }
      
      protected function __huikuiClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FlowerGivingController.instance.dispatchEvent(new FlowerSendRecordEvent("huiKuiFlower",_sender));
      }
      
      private function removeEvent() : void
      {
         _huikuiBtn.removeEventListener("click",__huikuiClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         this.graphics.clear();
         ObjectUtils.disposeAllChildren(this);
         _timeTxt = null;
         _contentTxt = null;
         _huikuiBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
