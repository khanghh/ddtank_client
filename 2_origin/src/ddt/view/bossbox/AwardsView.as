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
      
      private function _click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("_haveBtnClick"));
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      public function set boxType(param1:int) : void
      {
         _boxType = param1 + 1;
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
      
      public function set goodsList(param1:Array) : void
      {
         _goodsList = param1;
         list = ComponentFactory.Instance.creatCustomObject("bossbox.AwardsGoodsList");
         list.show(_goodsList);
         addChild(list);
      }
      
      public function set vipAwardGoodsList(param1:Array) : void
      {
         _goodsList = param1;
         list = ComponentFactory.Instance.creatCustomObject("bossbox.AwardsGoodsList");
         list.showForVipAward(_goodsList);
         addChild(list);
      }
      
      public function set fightLibAwardGoodList(param1:Array) : void
      {
         goodsList = param1;
         list = ComponentFactory.Instance.creatCustomObject("bossbox.AwardsGoodsList");
         list.show(_goodsList);
         addChild(list);
      }
      
      public function setCheck() : void
      {
         closeButton.visible = true;
         _button.enable = false;
         _timeTip.visible = false;
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("bossbox.TheNextTimeText");
         addToContent(_loc1_);
         _loc1_.text = LanguageMgr.GetTranslation("ddt.view.bossbox.AwardsView.TheNextTimeText",updateTime());
      }
      
      private function updateTime() : String
      {
         var _loc5_:Number = BossBoxManager.instance.delaySumTime * 1000 + TimeManager.Instance.Now().time;
         var _loc4_:Date = new Date(_loc5_);
         var _loc2_:int = _loc4_.hours;
         var _loc1_:int = _loc4_.minutes;
         var _loc3_:String = "";
         if(_loc2_ < 10)
         {
            _loc3_ = _loc3_ + ("0" + _loc2_);
         }
         else
         {
            _loc3_ = _loc3_ + _loc2_;
         }
         _loc3_ = _loc3_ + "giờ";
         if(_loc1_ < 10)
         {
            _loc3_ = _loc3_ + ("0" + _loc1_);
         }
         else
         {
            _loc3_ = _loc3_ + _loc1_;
         }
         _loc3_ = _loc3_ + "phút";
         return _loc3_;
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
