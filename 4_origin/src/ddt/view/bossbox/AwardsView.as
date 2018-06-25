package ddt.view.bossbox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.Helpers;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AwardsView extends Frame
   {
      
      public static const HAVEBTNCLICK:String = "_haveBtnClick";
       
      
      private var _timeTip:ScaleFrameImage;
      
      private var _goodsList:Array;
      
      private var _boxType:int;
      
      private var _button:TextButton;
      
      private var list:AwardsGoodsList;
      
      private var GoodsBG:ScaleBitmapImage;
      
      private var _view:MutipleImage;
      
      public function AwardsView()
      {
         super();
         initII();
         initEvent();
      }
      
      private function initII() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.timeBox.awardsInfo");
         GoodsBG = ComponentFactory.Instance.creat("bossbox.scale9GoodsImage");
         addToContent(GoodsBG);
         _view = ComponentFactory.Instance.creat("bossbox.AwardsAsset");
         addToContent(_view);
         _timeTip = ComponentFactory.Instance.creat("bossbox.TipAsset");
         addToContent(_timeTip);
         _button = ComponentFactory.Instance.creat("bossbox.BoxGetButton");
         _button.text = LanguageMgr.GetTranslation("ok");
         addToContent(_button);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _button.addEventListener("click",_click);
      }
      
      private function _click(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("_haveBtnClick"));
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      public function set boxType(value:int) : void
      {
         _boxType = value + 1;
         _timeTip.setFrame(_boxType);
         if(_boxType == 3)
         {
            GoodsBG.height = 83;
            _button.y = 177;
         }
         else if(_boxType == 4)
         {
            _button.visible = false;
         }
         else if(_boxType == 5)
         {
            GoodsBG.height = 230;
            _button.visible = false;
         }
         else
         {
            GoodsBG.height = 203;
            _button.y = 297;
         }
      }
      
      public function get boxType() : int
      {
         return _boxType;
      }
      
      public function set goodsList(templateIds:Array) : void
      {
         _goodsList = templateIds;
         list = ComponentFactory.Instance.creatCustomObject("bossbox.AwardsGoodsList");
         list.show(_goodsList);
         addChild(list);
      }
      
      public function set vipAwardGoodsList(templateIds:Array) : void
      {
         _goodsList = templateIds;
         list = ComponentFactory.Instance.creatCustomObject("bossbox.AwardsGoodsList");
         list.showForVipAward(_goodsList);
         addChild(list);
      }
      
      public function set fightLibAwardGoodList(templateids:Array) : void
      {
         goodsList = templateids;
         list = ComponentFactory.Instance.creatCustomObject("bossbox.AwardsGoodsList");
         list.show(_goodsList);
         addChild(list);
      }
      
      public function setCheck() : void
      {
         closeButton.visible = true;
         _button.enable = false;
         _timeTip.visible = false;
         var txt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("bossbox.TheNextTimeText");
         addToContent(txt);
         txt.text = LanguageMgr.GetTranslation("ddt.view.bossbox.AwardsView.TheNextTimeText",updateTime());
      }
      
      private function updateTime() : String
      {
         var _timeSum:Number = BossBoxManager.instance.delaySumTime * 1000 + TimeManager.Instance.Now().time;
         var date:Date = new Date(_timeSum);
         var _hours:int = date.hours;
         var _minute:int = date.minutes;
         var str:String = "";
         if(_hours < 10)
         {
            str = str + ("0" + _hours);
         }
         else
         {
            str = str + _hours;
         }
         str = str + "giờ";
         if(_minute < 10)
         {
            str = str + ("0" + _minute);
         }
         else
         {
            str = str + _minute;
         }
         str = str + "phút";
         return str;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",__frameEventHandler);
         if(_timeTip)
         {
            ObjectUtils.disposeObject(_timeTip);
         }
         _timeTip = null;
         if(_button)
         {
            _button.removeEventListener("click",_click);
            ObjectUtils.disposeObject(_button);
         }
         _button = null;
         if(list)
         {
            ObjectUtils.disposeObject(list);
         }
         list = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get goodsList() : Array
      {
         return Helpers.clone(_goodsList) as Array;
      }
   }
}
