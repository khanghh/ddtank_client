package gameCommon.view.arrow
{
   import bombKing.BombKingManager;
   import bombKing.event.BombKingEvent;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.GraphicsUtils;
   import ddt.view.common.GradientText;
   import ddt.view.tips.ToolPropInfo;
   import fightLib.FightLibManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import room.RoomManager;
   import room.model.WeaponInfo;
   
   public class ArrowView extends Sprite implements Disposeable
   {
      
      public static const FLY_CD:int = 2;
      
      public static const HIDE_BAR:String = "hide bar";
      
      public static const USE_TOOL:String = "use_tool";
      
      public static const ADD_BLOOD_CD:int = 2;
      
      public static const RANDOW_COLORSII:Array = [[1351165,16768512],[1478655,2607344],[1555258,14293039],[7912215,14293199],[12862218,7721224],[14577152,15970051],[6011902,832292],[521814,13411850],[15035908,11327256],[15118867,8369930],[2213785,8116729],[10735137,14497882],[15460371,15430666],[13032456,2861311],[16670299,12510266],[44799,7721224]];
      
      public static const ANGLE_NEXTCHANGE_TIME:int = 100;
       
      
      private var _bg:ArrowBg;
      
      private var _info:LocalPlayer;
      
      private var _sector:Sprite;
      
      private var _recordChangeBefore:Number;
      
      private var _flyCoolDown:int = 0;
      
      private var _flyEnable:Boolean;
      
      private var _isLockFly:Boolean = false;
      
      private var rotationCountField:GradientText;
      
      private var _hammerCoolDown:int = 0;
      
      private var _hammerEnable:Boolean;
      
      private var _deputyWeaponResCount:int;
      
      private var _AngelLine:MovieClip;
      
      private var _ShineKey:Boolean;
      
      public var _AnglelShineEffect:IEffect;
      
      private var _wFlag:Boolean;
      
      private var _sFlag:Boolean;
      
      private var _angleNum:int;
      
      private var _hideState:Boolean;
      
      private var _enableArrow:Boolean;
      
      private var _currentAngleChangeTime:int = 0;
      
      private var _first:Boolean = true;
      
      private var _recordRotation:Number;
      
      private var _hammerBlocked:Boolean;
      
      public function ArrowView(param1:LocalPlayer)
      {
         super();
         _info = param1;
         _bg = ComponentFactory.Instance.creatCustomObject("game.view.arrowBg") as ArrowBg;
         addChild(_bg);
         _bg.arrowSub.arrowClone_mc.visible = false;
         _bg.arrowSub.arrowChonghe_mc.visible = false;
         _sector = GraphicsUtils.drawSector(0,0,55,0,90);
         _sector.y = 1;
         _bg.arrowSub.circle_mc.mask = _sector;
         _bg.arrowSub.circle_mc.visible = true;
         _bg.arrowSub.green_mc.visible = false;
         _bg.arrowSub.addChild(_sector);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("asset.game.rotationCountFieldText");
         rotationCountField = new GradientText(_loc2_,RANDOW_COLORSII);
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("asset.game.rotationCountPos");
         rotationCountField.x = _loc3_.x;
         rotationCountField.y = _loc3_.y;
         addChild(rotationCountField);
         rotationCountField.filters = ComponentFactory.Instance.creatFilters("game.rotationCountField_Filter");
         rotationCountField.setText(rotationCountField.text);
         reset();
         __changeDirection(null);
         flyEnable = true;
         hammerEnable = true;
         _flyCoolDown = 0;
         _hammerCoolDown = 0;
         if(_info.selfInfo && _info.selfInfo.DeputyWeapon)
         {
            _deputyWeaponResCount = _info.selfInfo.DeputyWeapon.StrengthenLevel + 1;
         }
         updataAngleLine();
      }
      
      public function set flyEnable(param1:Boolean) : void
      {
         if(param1 == _flyEnable)
         {
            return;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(11))
         {
            param1 = false;
         }
         _flyEnable = param1;
         if(_isLockFly)
         {
            _info.flyEnabled = false;
         }
         else
         {
            _info.flyEnabled = _flyEnable;
         }
      }
      
      private function __sendShootAction(param1:LivingEvent) : void
      {
         var _loc2_:LocalPlayer = param1.currentTarget as LocalPlayer;
         if(_loc2_.currentBomb == 3)
         {
            _info.removeEventListener("sendShootAction",__sendShootAction);
            SocketManager.Instance.out.syncWeakStep(94);
         }
      }
      
      public function set hammerEnable(param1:Boolean) : void
      {
         if(param1 == _hammerEnable)
         {
            return;
         }
         if(!_info.hasDeputyWeapon())
         {
            _hammerEnable = false;
         }
         else
         {
            _hammerEnable = param1;
         }
         _info.deputyWeaponEnabled = _hammerEnable;
      }
      
      public function get hammerEnable() : Boolean
      {
         return _hammerEnable;
      }
      
      public function disable() : void
      {
         flyEnable = false;
         if(!_info.currentDeputyWeaponInfo.isShield)
         {
            hammerEnable = false;
         }
      }
      
      private function updataAngleLine() : void
      {
         if(RoomManager.Instance.current.gameMode == 8)
         {
            showAngleLine(FightLibManager.Instance.currentInfo.id);
         }
      }
      
      private function showAngleLine(param1:int) : void
      {
         if(!_AngelLine)
         {
            _AngelLine = ComponentFactory.Instance.creatCustomObject("game.fightLib.AngleStyle");
            addChild(_AngelLine);
            _AngelLine.gotoAndStop("stand");
         }
         switch(int(param1) - 1001)
         {
            case 0:
               _AngelLine.gotoAndStop("20Degree");
               break;
            case 1:
               _AngelLine.gotoAndStop("65Degree");
               break;
            case 2:
               _AngelLine.gotoAndStop("90Degree");
         }
         _AnglelShineEffect = EffectManager.Instance.creatEffect(3,_AngelLine,{"color":"gold"});
      }
      
      private function setTip(param1:BaseButton, param2:String, param3:String, param4:String, param5:String = "0", param6:Boolean = true, param7:int = 10) : void
      {
         param1.tipStyle = "core.ToolPropTips";
         param1.tipDirctions = param5;
         param1.tipGapV = 0;
         param1.tipGapH = param7;
         var _loc9_:ItemTemplateInfo = new ItemTemplateInfo();
         _loc9_.Name = param2;
         _loc9_.Property4 = param3;
         _loc9_.Description = param4;
         var _loc8_:ToolPropInfo = new ToolPropInfo();
         _loc8_.info = _loc9_;
         _loc8_.count = 1;
         _loc8_.showTurn = false;
         _loc8_.showThew = param6;
         _loc8_.showCount = false;
         param1.tipData = _loc8_;
      }
      
      private function reset() : void
      {
         _bg.arrowSub.green_mc.mask = null;
         _bg.arrowSub.circle_mc.mask = _sector;
         _bg.arrowSub.circle_mc.visible = true;
         _bg.arrowSub.green_mc.visible = false;
         if(_info && _info.currentWeapInfo)
         {
            if(RoomManager.Instance.current.type == 29)
            {
               GraphicsUtils.changeSectorAngle(_sector,0,0,55,0,90);
            }
            else
            {
               GraphicsUtils.changeSectorAngle(_sector,0,0,55,_info.currentWeapInfo.armMinAngle,_info.currentWeapInfo.armMaxAngle - _info.currentWeapInfo.armMinAngle + 1);
            }
         }
      }
      
      public function set hideState(param1:Boolean) : void
      {
         _hideState = param1;
      }
      
      public function get hideState() : Boolean
      {
         return _hideState;
      }
      
      private function carrayAngle() : void
      {
         _bg.arrowSub.circle_mc.mask = null;
         _bg.arrowSub.green_mc.mask = _sector;
         _bg.arrowSub.circle_mc.visible = false;
         _bg.arrowSub.green_mc.visible = true;
         GraphicsUtils.changeSectorAngle(_sector,0,0,55,0,90);
      }
      
      public function dispose() : void
      {
         if(_AnglelShineEffect)
         {
            EffectManager.Instance.removeEffect(_AnglelShineEffect);
         }
         FightLibManager.Instance.isWork = false;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_sector);
         ObjectUtils.disposeObject(rotationCountField);
         ObjectUtils.disposeObject(_AngelLine);
         _bg = null;
         _info = null;
         _sector = null;
         rotationCountField = null;
         _AngelLine = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initEvents() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(94) && PlayerManager.Instance.Self.IsWeakGuildFinish(11))
         {
            _info.addEventListener("sendShootAction",__sendShootAction);
         }
         _info.addEventListener("gunangleChanged",__weapAngle);
         _info.addEventListener("dirChanged",__changeDirection);
         _info.addEventListener("angleChanged",__changeAngle);
         _info.addEventListener("bombChanged",__changeBall);
         _info.addEventListener("attackingChanged",__setArrowClone);
         _info.addEventListener("attackingChanged",__change);
         _info.addEventListener("beginNewTurn",__onTurnChange);
         _info.addEventListener("die",__die);
         _info.addEventListener("livingRevive",__revive);
         _info.addEventListener("lockAngleChange",__lockAngleChangeHandler);
         addEventListener("enterFrame",__enterFrame);
         KeyboardManager.getInstance().addEventListener("keyDown",__keydown);
         KeyboardManager.getInstance().addEventListener("keyDown",__inputKeyDown);
         SocketManager.Instance.addEventListener("Use_Deputy_Weapon",__setDeputyWeaponNumber);
         BombKingManager.instance.addEventListener("recordingModifyAngle",__onModifyAngle);
      }
      
      private function removeEvent() : void
      {
         _info.removeEventListener("sendShootAction",__sendShootAction);
         _info.removeEventListener("gunangleChanged",__weapAngle);
         _info.removeEventListener("dirChanged",__changeDirection);
         _info.removeEventListener("angleChanged",__changeAngle);
         _info.removeEventListener("bombChanged",__changeBall);
         _info.removeEventListener("attackingChanged",__setArrowClone);
         _info.removeEventListener("attackingChanged",__change);
         _info.removeEventListener("die",__die);
         _info.removeEventListener("livingRevive",__revive);
         _info.removeEventListener("beginNewTurn",__onTurnChange);
         _info.removeEventListener("lockAngleChange",__lockAngleChangeHandler);
         removeEventListener("enterFrame",__enterFrame);
         KeyboardManager.getInstance().removeEventListener("keyDown",__keydown);
         KeyboardManager.getInstance().removeEventListener("keyDown",__inputKeyDown);
         SocketManager.Instance.removeEventListener("Use_Deputy_Weapon",__setDeputyWeaponNumber);
         BombKingManager.instance.removeEventListener("recordingModifyAngle",__onModifyAngle);
      }
      
      private function __lockAngleChangeHandler(param1:LivingEvent) : void
      {
         enableArrow = _info.isLockAngle;
      }
      
      public function set enableArrow(param1:Boolean) : void
      {
         _enableArrow = param1;
         if(!param1)
         {
            addEventListener("enterFrame",__enterFrame);
            KeyboardManager.getInstance().addEventListener("keyDown",__inputKeyDown);
         }
         else
         {
            KeyboardManager.getInstance().removeEventListener("keyDown",__inputKeyDown);
            removeEventListener("enterFrame",__enterFrame);
         }
      }
      
      protected function __onModifyAngle(param1:BombKingEvent) : void
      {
         var _loc2_:Object = param1.data;
         _angleNum = int(_loc2_.angle);
         _info.direction = int(_loc2_.direction);
         __changeDirection(null);
      }
      
      public function modifyAngleData(param1:Player) : void
      {
         _info.currentWeapInfo = param1.currentWeapInfo;
         _info.playerAngle = param1.playerAngle;
         reset();
      }
      
      private function __onTurnChange(param1:LivingEvent) : void
      {
         rotationCountField.setText(rotationCountField.text);
      }
      
      private function __die(param1:Event) : void
      {
         if(!_info.isLiving)
         {
            flyEnable = false;
            hammerEnable = false;
         }
      }
      
      private function __revive(param1:Event) : void
      {
         flyEnable = true;
         hammerEnable = true;
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = getTimer();
         if(_loc2_ - _currentAngleChangeTime < 100)
         {
            return;
         }
         var _loc4_:Boolean = false;
         if(BombKingManager.instance.Recording)
         {
            _sFlag = _info.gunAngle > _angleNum;
            _wFlag = _info.gunAngle < _angleNum;
         }
         if((_sFlag || KeyboardManager.isDown(KeyStroke.VK_S.getCode()) || KeyboardManager.isDown(40)) && !_info.autoOnHook)
         {
            if(_currentAngleChangeTime != 0)
            {
               _loc4_ = _info.manuallySetGunAngle(_info.gunAngle - WeaponInfo.ROTATITON_SPEED * _info.reverse);
            }
            else
            {
               _currentAngleChangeTime = getTimer();
            }
            _loc3_ = true;
         }
         else if((_wFlag || KeyboardManager.isDown(KeyStroke.VK_W.getCode()) || KeyboardManager.isDown(38)) && !_info.autoOnHook)
         {
            if(_currentAngleChangeTime != 0)
            {
               _loc4_ = _info.manuallySetGunAngle(_info.gunAngle + WeaponInfo.ROTATITON_SPEED * _info.reverse);
            }
            if(_currentAngleChangeTime == 0)
            {
               _currentAngleChangeTime = getTimer();
            }
            _loc3_ = true;
         }
         if(!_loc3_)
         {
            _currentAngleChangeTime = 0;
         }
         if(_loc4_)
         {
            SoundManager.instance.play("006");
         }
      }
      
      private function __inputKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:Boolean = false;
         if(!ChatManager.Instance.input.inputField.isFocus() && !_info.autoOnHook)
         {
            if(!BombKingManager.instance.Recording)
            {
               _loc2_ = false;
               if((param1.keyCode == KeyStroke.VK_S.getCode() || param1.keyCode == 40) && !_info.autoOnHook)
               {
                  _loc2_ = _info.manuallySetGunAngle(_info.gunAngle - WeaponInfo.ROTATITON_SPEED * _info.reverse);
                  _currentAngleChangeTime = 0;
               }
               else if((param1.keyCode == KeyStroke.VK_W.getCode() || param1.keyCode == 38) && !_info.autoOnHook)
               {
                  _loc2_ = _info.manuallySetGunAngle(_info.gunAngle + WeaponInfo.ROTATITON_SPEED * _info.reverse);
                  _currentAngleChangeTime = 0;
               }
               if(_loc2_)
               {
                  SoundManager.instance.play("006");
               }
            }
         }
      }
      
      private function __keydown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode != KeyStroke.VK_F.getCode())
         {
            if(param1.keyCode == KeyStroke.VK_T.getCode())
            {
               dispatchEvent(new Event("hide bar"));
            }
         }
      }
      
      private function __changeBall(param1:LivingEvent) : void
      {
         if(_info.currentBomb == 3 || _info.currentBomb == 110 || _info.currentBomb == 117 || _info.currentBomb == 11196)
         {
            carrayAngle();
         }
         else
         {
            resetAngle();
         }
      }
      
      private function resetAngle() : void
      {
         reset();
      }
      
      private function __change(param1:LivingEvent) : void
      {
         if(_info == null)
         {
            return;
         }
         var _loc2_:Number = _info.currentDeputyWeaponInfo.energy;
         resetAngle();
      }
      
      private function __weapAngle(param1:LivingEvent) : void
      {
         if(RoomManager.Instance.current.gameMode == 8)
         {
            checkAngle();
         }
         var _loc2_:* = 0;
         if(_info.direction == -1)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = Number(180);
         }
         if(_info.gunAngle < 0)
         {
            _bg.arrowSub.arrow.rotation = 360 - (_info.gunAngle - 180 + _loc2_) * _info.direction;
         }
         else
         {
            _bg.arrowSub.arrow.rotation = 360 - (_info.gunAngle + 180 + _loc2_) * _info.direction;
         }
         _recordChangeBefore = _info.gunAngle;
         rotationCountField.setText(String(int(_info.gunAngle + _info.playerAngle * -1 * _info.direction)),false);
         if(_bg.arrowSub.arrow.rotation == _bg.arrowSub.arrowClone_mc.rotation)
         {
            _bg.arrowSub.arrowChonghe_mc.visible = true;
            _bg.arrowSub.arrowChonghe_mc.rotation = _bg.arrowSub.arrow.rotation;
            _bg.arrowSub.arrowClone_mc.visible = false;
            _bg.arrowSub.arrow.visible = false;
         }
         else
         {
            _bg.arrowSub.arrowChonghe_mc.visible = false;
            _bg.arrowSub.arrowClone_mc.visible = !!_first?false:true;
            _bg.arrowSub.arrow.visible = true;
         }
      }
      
      private function checkAngle() : void
      {
         if(_info.direction !== 1 || !_AnglelShineEffect)
         {
            return;
         }
         var _loc1_:int = _info.gunAngle + _info.playerAngle * -1 * _info.direction;
         if(FightLibManager.Instance.currentInfo)
         {
            switch(int(FightLibManager.Instance.currentInfo.id) - 1001)
            {
               case 0:
                  if(_loc1_ > 30 || _loc1_ < 10)
                  {
                     ShineKey = true;
                  }
                  else
                  {
                     ShineKey = false;
                  }
                  break;
               case 1:
                  if(_loc1_ > 75 || _loc1_ < 55)
                  {
                     ShineKey = true;
                  }
                  else
                  {
                     ShineKey = false;
                  }
                  break;
               case 2:
                  if(_loc1_ > 100 || _loc1_ < 60)
                  {
                     ShineKey = true;
                     break;
                  }
                  ShineKey = false;
                  break;
            }
         }
      }
      
      public function set ShineKey(param1:Boolean) : void
      {
         if(_ShineKey == param1)
         {
            return;
         }
         _ShineKey = param1;
         shineAngleLine();
      }
      
      public function get ShineKey() : Boolean
      {
         return _ShineKey;
      }
      
      private function shineAngleLine() : void
      {
         if(_ShineKey == true)
         {
            FightLibManager.Instance.isWork = true;
            _AnglelShineEffect.play();
         }
         else
         {
            FightLibManager.Instance.isWork = false;
            _AnglelShineEffect.stop();
         }
      }
      
      private function __changeDirection(param1:LivingEvent) : void
      {
         __weapAngle(null);
         if(_info.direction == -1)
         {
            _sector.scaleX = -1;
            if(_AnglelShineEffect)
            {
               ShineKey = true;
            }
         }
         else
         {
            _sector.scaleX = 1;
         }
      }
      
      private function __changeAngle(param1:LivingEvent) : void
      {
         if(RoomManager.Instance.current.gameMode == 8)
         {
            checkAngle();
         }
         var _loc2_:Number = _bg.arrowSub.rotation - _info.playerAngle;
         _bg.arrowSub.rotation = _info.playerAngle;
         _recordRotation = _recordRotation + _loc2_;
         _bg.arrowSub.arrowClone_mc.rotation = _recordRotation;
         rotationCountField.setText(String(int(_info.gunAngle + _info.playerAngle * -1 * _info.direction)),false);
         if(_bg.arrowSub.arrow.rotation == _bg.arrowSub.arrowClone_mc.rotation)
         {
            _bg.arrowSub.arrowChonghe_mc.visible = true;
            _bg.arrowSub.arrowChonghe_mc.rotation = _bg.arrowSub.arrow.rotation;
            _bg.arrowSub.arrowClone_mc.visible = false;
            _bg.arrowSub.arrow.visible = false;
         }
         else
         {
            _bg.arrowSub.arrowChonghe_mc.visible = false;
            _bg.arrowSub.arrowClone_mc.visible = !!_first?false:true;
            _bg.arrowSub.arrow.visible = true;
         }
      }
      
      private function __setArrowClone(param1:Event) : void
      {
         if(!_info.isAttacking)
         {
            _first = false;
            _bg.arrowSub.arrowClone_mc.visible = true;
            _recordRotation = _bg.arrowSub.arrow.rotation;
            _bg.arrowSub.arrowClone_mc.rotation = _bg.arrowSub.arrow.rotation;
         }
      }
      
      public function setRecordRotation() : void
      {
         _first = false;
         _bg.arrowSub.arrowClone_mc.visible = true;
         _recordRotation = _bg.arrowSub.arrow.rotation;
         _bg.arrowSub.arrowClone_mc.rotation = _bg.arrowSub.arrow.rotation;
      }
      
      public function blockHammer() : void
      {
         _hammerBlocked = true;
         _hammerCoolDown = 100000;
      }
      
      public function allowHammer() : void
      {
         _hammerBlocked = false;
         _hammerCoolDown = 0;
      }
      
      private function __setDeputyWeaponNumber(param1:CrazyTankSocketEvent) : void
      {
         _deputyWeaponResCount = param1.pkg.readInt();
         _info.deputyWeaponCount = _deputyWeaponResCount;
      }
      
      public function get transparentBtn() : SimpleBitmapButton
      {
         return null;
      }
      
      public function setPlaneBtnVisible(param1:Boolean) : void
      {
         flyEnable = param1;
      }
      
      public function setOffHandedBtnVisible(param1:Boolean) : void
      {
         hammerEnable = param1;
      }
      
      public function enter() : void
      {
         initEvents();
         __changeAngle(null);
      }
      
      public function leaving() : void
      {
         removeEvent();
      }
   }
}
