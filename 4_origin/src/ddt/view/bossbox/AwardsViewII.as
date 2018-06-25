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
         var bit:Bitmap = ComponentFactory.Instance.creatBitmap("asset.vip.monyBG");
         addToContent(bit);
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
      
      private function _click(evt:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         var vRewardBindBid:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _goodsList;
         for each(var boxGoodItem in _goodsList)
         {
            if(boxGoodItem.TemplateId == -300)
            {
               vRewardBindBid = boxGoodItem.ItemCount;
               break;
            }
         }
         if(vRewardBindBid + PlayerManager.Instance.Self.DDTMoney > ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.BindBid.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"),false,false,true,1);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            PlayerManager.Instance.Self.canTakeVipReward = false;
            MainButtnController.instance.dispatchEvent(new Event(MainButtnController.ICONCLOSE));
            dispatchEvent(new Event("_haveBtnClick"));
         }
      }
      
      private function __onResponse(pEvent:FrameEvent) : void
      {
         pEvent.currentTarget.removeEventListener("response",__onResponse);
         if(pEvent.responseCode == 3)
         {
            PlayerManager.Instance.Self.canTakeVipReward = false;
            MainButtnController.instance.dispatchEvent(new Event(MainButtnController.ICONCLOSE));
            dispatchEvent(new Event("_haveBtnClick"));
         }
         ObjectUtils.disposeObject(pEvent.currentTarget);
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
         _timeTypeTxt.visible = false;
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
         str = str + "点";
         if(_minute < 10)
         {
            str = str + ("0" + _minute);
         }
         else
         {
            str = str + _minute;
         }
         str = str + "分";
         return str;
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
