package consortion.view.selfConsortia
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaApplyInfo;
   import ddt.data.player.BasePlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class TakeInMemberItem extends Sprite implements Disposeable
   {
       
      
      public var FightPower:int;
      
      public var Level:int;
      
      private var _selected:Boolean;
      
      private var _info:ConsortiaApplyInfo;
      
      private var _nameSelect:SelectedCheckButton;
      
      private var _name:FilterFrameText;
      
      private var _nameForVip:GradientText;
      
      private var _level:LevelIcon;
      
      private var _power:FilterFrameText;
      
      private var _check:TextButton;
      
      private var _agree:TextButton;
      
      private var _refuse:TextButton;
      
      public function TakeInMemberItem()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get height() : Number
      {
         return 30;
      }
      
      private function initView() : void
      {
         _selected = false;
         _nameSelect = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.select");
         _name = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.name");
         _level = ComponentFactory.Instance.creatCustomObject("consortion.takeIn.levelIcon");
         _power = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.power");
         _check = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.check");
         _check.text = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.view");
         _agree = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.agree");
         _agree.text = LanguageMgr.GetTranslation("tank.gametrainer.view.agree");
         _refuse = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.refuse");
         _refuse.text = LanguageMgr.GetTranslation("tank.view.common.NPCPairingDialog.refuse");
         addChild(_nameSelect);
         addChild(_level);
         addChild(_power);
         addChild(_check);
         addChild(_agree);
         addChild(_refuse);
         _level.setSize(1);
      }
      
      private function initEvent() : void
      {
         _nameSelect.addEventListener("click",__selectHandler);
         _check.addEventListener("click",__checkHandler);
         _agree.addEventListener("click",__agreeHandler);
         _refuse.addEventListener("click",__refuseHandler);
      }
      
      private function removeEvent() : void
      {
         _nameSelect.removeEventListener("click",__selectHandler);
         _check.removeEventListener("click",__checkHandler);
         _agree.removeEventListener("click",__agreeHandler);
         _refuse.removeEventListener("click",__refuseHandler);
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _nameSelect.selected = param1;
      }
      
      public function get selected() : Boolean
      {
         return _nameSelect.selected;
      }
      
      public function set info(param1:ConsortiaApplyInfo) : void
      {
         _info = param1;
         if(_info.IsVIP)
         {
            ObjectUtils.disposeObject(_nameForVip);
            _nameForVip = VipController.instance.getVipNameTxt(113,_info.typeVIP);
            _nameForVip.textSize = 16;
            _nameForVip.x = _name.x;
            _nameForVip.y = _name.y;
            _nameForVip.text = _info.UserName;
            _nameSelect.addChild(_nameForVip);
         }
         _name.text = _info.UserName;
         _nameSelect.addChild(_name);
         var _loc2_:BasePlayer = new BasePlayer();
         _loc2_.isOld = _info.IsOld;
         _loc2_.IsVIP = _info.IsVIP;
         PositionUtils.adaptNameStyle(_loc2_,_name,_nameForVip);
         _level.setInfo(_info.UserLevel,_info.ddtKingGrade,_info.Repute,_info.Win,_info.Total,_info.FightPower,_info.Offer);
         Level = _info.UserLevel;
         _power.text = String(_info.FightPower);
         FightPower = _info.FightPower;
      }
      
      public function get info() : ConsortiaApplyInfo
      {
         return _info;
      }
      
      private function __selectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         selected = _selected == true?false:true;
      }
      
      private function __checkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PlayerInfoViewControl.viewByID(_info.UserID,PlayerManager.Instance.Self.ZoneID);
      }
      
      private function __agreeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendConsortiaTryinPass(_info.ID);
      }
      
      private function __refuseHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendConsortiaTryinDelete(_info.ID);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _nameSelect = null;
         _nameForVip = null;
         _level = null;
         _name = null;
         _power = null;
         _check = null;
         _agree = null;
         _refuse = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
