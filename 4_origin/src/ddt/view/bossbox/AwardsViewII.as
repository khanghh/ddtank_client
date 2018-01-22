package ddt.view.bossbox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainbutton.MainButtnController;
   
   public class AwardsViewII extends Frame
   {
      
      public static const HAVEBTNCLICK:String = "_haveBtnClick";
       
      
      private var _timeTypeTxt:FilterFrameText;
      
      private var _goodsList:Array;
      
      private var _boxType:int;
      
      private var _button:TextButton;
      
      private var list:AwardsGoodsList;
      
      private var GoodsBG:ScaleBitmapImage;
      
      public function AwardsViewII()
      {
         super();
         initII();
         initEvent();
      }
      
      private function initII() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.timeBox.awardsInfo");
         GoodsBG = ComponentFactory.Instance.creat("bossbox.scale9GoodsImageII");
         addToContent(GoodsBG);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.vip.monyBG");
         addToContent(_loc1_);
         _timeTypeTxt = ComponentFactory.Instance.creat("bossbox.awardsTitleTxt");
         _timeTypeTxt.text = LanguageMgr.GetTranslation("ddt.vip.awardsTitleTxt");
         addToContent(_timeTypeTxt);
         _button = ComponentFactory.Instance.creat("bossbox.BoxGetButtonII");
         _button.text = LanguageMgr.GetTranslation("ok");
         addToContent(_button);
         if(!PlayerManager.Instance.Self.IsVIP)
         {
            _button.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _button.addEventListener("click",_click);
      }
      
      private function _click(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _goodsList;
         for each(var _loc4_ in _goodsList)
         {
            if(_loc4_.TemplateId == -300)
            {
               _loc3_ = _loc4_.ItemCount;
               break;
            }
         }
         if(_loc3_ + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            _loc2_.addEventListener("response",__onResponse);
         }
         else
         {
            PlayerManager.Instance.Self.canTakeVipReward = false;
            MainButtnController.instance.dispatchEvent(new Event(MainButtnController.ICONCLOSE));
            dispatchEvent(new Event("_haveBtnClick"));
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onResponse);
         if(param1.responseCode == 3)
         {
            PlayerManager.Instance.Self.canTakeVipReward = false;
            MainButtnController.instance.dispatchEvent(new Event(MainButtnController.ICONCLOSE));
            dispatchEvent(new Event("_haveBtnClick"));
         }
         ObjectUtils.disposeObject(param1.currentTarget);
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
         _timeTypeTxt.visible = false;
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
         _loc3_ = _loc3_ + "点";
         if(_loc1_ < 10)
         {
            _loc3_ = _loc3_ + ("0" + _loc1_);
         }
         else
         {
            _loc3_ = _loc3_ + _loc1_;
         }
         _loc3_ = _loc3_ + "分";
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",__frameEventHandler);
         if(_timeTypeTxt)
         {
            ObjectUtils.disposeObject(_timeTypeTxt);
         }
         _timeTypeTxt = null;
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
   }
}
