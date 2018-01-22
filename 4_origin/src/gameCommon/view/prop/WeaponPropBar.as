package gameCommon.view.prop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.player.ConsortiaBattlePlayerInfo;
   import consortionBattle.view.ConsBatLosingStreakBuff;
   import ddt.data.PropInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyStroke;
   import room.RoomManager;
   import trainer.controller.NewHandGuideManager;
   import trainer.view.NewHandContainer;
   
   public class WeaponPropBar extends FightPropBar
   {
       
      
      private var _canEnable:Boolean = true;
      
      protected var _losingStreakIcon:ConsBatLosingStreakBuff;
      
      private var _localFlyVisible:Boolean = true;
      
      private var _localDeputyWeaponVisible:Boolean = true;
      
      private var _localVisible:Boolean = true;
      
      private var _localFlyEnabled:Boolean = true;
      
      public function WeaponPropBar(param1:LocalPlayer)
      {
         super(param1);
         _canEnable = weaponEnabled();
         visibleFlyForWorldBoss();
         updatePropByEnergy();
         initLosingStreakInConsBat();
      }
      
      private function visibleFlyForWorldBoss() : void
      {
         if(_self && RoomManager.Instance.current.type == 14 || RoomManager.Instance.current.type == 48 || RoomManager.Instance.current.type == 151)
         {
            setFlyEnabled(false);
         }
      }
      
      private function initLosingStreakInConsBat() : void
      {
         if(RoomManager.Instance.current.type != 19)
         {
            return;
         }
         var _loc1_:ConsortiaBattlePlayerInfo = ConsortiaBattleManager.instance.getPlayerInfo(PlayerManager.Instance.Self.ID);
         if(_loc1_.failBuffCount > 0)
         {
            _losingStreakIcon = ComponentFactory.Instance.creatComponentByStylename("gameView.ConsBatLosingStreakBuff");
            addChild(_losingStreakIcon);
            if(_cells[1])
            {
               _cells[1].visible = false;
            }
         }
      }
      
      private function weaponEnabled() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:ItemTemplateInfo = _self.currentDeputyWeaponInfo.Template;
         if(_loc1_.TemplateID == 17200)
         {
            _loc2_ = RoomManager.Instance.current.type;
            if(_loc2_ == 4 || _loc2_ == 11 || _loc2_ == 21 || _loc2_ == 14 || _loc2_ == 123 || _loc2_ == 151 || StateManager.currentStateType == "fightLabGameView")
            {
               return false;
            }
         }
         if(RoomManager.Instance.current.type == 19)
         {
            return false;
         }
         return true;
      }
      
      override protected function updatePropByEnergy() : void
      {
         _cells[0].enabled = _localFlyEnabled && _self.flyEnabled;
         if(!_canEnable)
         {
            _self.deputyWeaponEnabled = false;
            _cells[1].setGrayFilter();
            _cells[1].removeEventListener("click",__itemClicked);
         }
         _cells[1].enabled = _self.deputyWeaponEnabled;
         if(!_self.flyEnabled)
         {
            hideGuidePlane();
         }
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 18)
         {
            _cells[1].info = null;
            _cells[1].removeEventListener("click",__itemClicked);
         }
      }
      
      override protected function __itemClicked(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!_localVisible)
         {
            return;
         }
         var _loc4_:PropCell = param1.currentTarget as PropCell;
         SoundManager.instance.play("008");
         var _loc3_:int = _cells.indexOf(_loc4_);
         switch(int(_loc3_))
         {
            case 0:
               if(!_localFlyEnabled || !_localFlyVisible)
               {
                  return;
               }
               _loc2_ = _self.useFly();
               break;
            case 1:
               if(!_localDeputyWeaponVisible)
               {
                  return;
               }
               if(_self.isLocked)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onlyFly"));
                  return;
               }
               _loc2_ = _self.useDeputyWeapon();
               break;
         }
         if(_loc2_ == "2")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.NotCoolDown",_self.flyCoolDown));
         }
         else if(_loc2_ == "4")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.NotCoolDown",_self.deputyWeaponCoolDown));
         }
         else if(_loc2_ == "5")
         {
            var _loc5_:* = _self.selfInfo.DeputyWeapon.TemplateID;
            if(17001 !== _loc5_)
            {
               if(17002 !== _loc5_)
               {
                  if(17005 !== _loc5_)
                  {
                     if(17000 !== _loc5_)
                     {
                        if(17010 !== _loc5_)
                        {
                           if(17101 !== _loc5_)
                           {
                              if(17003 !== _loc5_)
                              {
                                 if(17004 !== _loc5_)
                                 {
                                    if(17200 === _loc5_)
                                    {
                                       MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.deputyWeapon.canNotUse4"));
                                    }
                                 }
                                 else
                                 {
                                    MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.deputyWeapon.canNotUse3"));
                                 }
                              }
                              else
                              {
                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.deputyWeapon.canNotUse2"));
                              }
                           }
                           addr157:
                        }
                        addr98:
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.deputyWeapon.canNotUse"));
                        §§goto(addr157);
                     }
                     addr97:
                     §§goto(addr98);
                  }
                  addr96:
                  §§goto(addr97);
               }
               addr95:
               §§goto(addr96);
            }
            §§goto(addr95);
         }
         else if(_loc2_ != "0")
         {
            if(_loc2_ != "LockState" || RoomManager.Instance.current.type != 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + _loc2_));
            }
         }
         else if(_loc3_ == 0)
         {
            hideGuidePlane();
            if(NewHandGuideManager.Instance.mapID == 115)
            {
               if(_self.pos.x < 990)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.view.arrow.ArrowView.energy"));
               }
            }
            else if(!PlayerManager.Instance.Self.IsWeakGuildFinish(94) && PlayerManager.Instance.Self.IsWeakGuildFinish(11))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.view.arrow.ArrowView.energy"));
            }
         }
         StageReferance.stage.focus = null;
      }
      
      override protected function __keyDown(param1:KeyboardEvent) : void
      {
         if(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI)
         {
            return;
         }
         var _loc2_:* = param1.keyCode;
         if(KeyStroke.VK_F.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_R.getCode() === _loc2_)
            {
               if(_self.isLocked)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onlyFly"));
                  return;
               }
               if(RoomManager.Instance.current.type != 18 && RoomManager.Instance.current.type != 19)
               {
                  _cells[1].useProp();
               }
            }
         }
         else
         {
            _cells[0].useProp();
         }
         super.__keyDown(param1);
      }
      
      override protected function addEvent() : void
      {
         _self.addEventListener("flyChanged",__flyChanged);
         _self.addEventListener("deputyweapin_Changed",__deputyWeaponChanged);
         _self.addEventListener("attackingChanged",__changeAttack);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.addEventListener("click",__itemClicked);
         }
         super.addEvent();
      }
      
      override protected function __changeAttack(param1:LivingEvent) : void
      {
         if(_self.isAttacking)
         {
            showGuidePlane();
            updatePropByEnergy();
         }
         else
         {
            hideGuidePlane();
         }
      }
      
      private function showGuidePlane() : void
      {
         if(NewHandGuideManager.Instance.mapID == 115)
         {
            if(_self.pos.x < 990)
            {
               if(_self.flyEnabled)
               {
                  NewHandContainer.Instance.showArrow(22,30,"trainer.posPlaneI");
               }
            }
         }
      }
      
      private function hideGuidePlane() : void
      {
         if(NewHandContainer.Instance.hasArrow(22))
         {
            NewHandContainer.Instance.clearArrowByID(22);
         }
      }
      
      private function __setDeputyWeaponNumber(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         _cells[1].enabled = _loc2_ != 0;
         WeaponPropCell(_cells[1]).setCount(_loc2_);
      }
      
      private function __deputyWeaponChanged(param1:LivingEvent) : void
      {
         if(!_canEnable)
         {
            _self.deputyWeaponEnabled = false;
         }
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 18)
         {
            return;
         }
         _cells[1].enabled = _self.deputyWeaponEnabled;
         if(_canEnable)
         {
            WeaponPropCell(_cells[1]).setCount(_self.deputyWeaponCount);
         }
      }
      
      private function __flyChanged(param1:LivingEvent) : void
      {
         _cells[0].enabled = _localFlyEnabled && _self.flyEnabled;
         if(RoomManager.Instance.current.type == 19)
         {
            (_cells[0] as WeaponPropCell).setCount(_self.flyCount);
            if(_self.flyCount <= 0)
            {
               _cells[0].setGrayFilter();
               _cells[0].removeEventListener("click",__itemClicked);
            }
         }
      }
      
      override protected function configUI() : void
      {
         _background = ComponentFactory.Instance.creatBitmap("asset.game.prop.WeaponBack");
         addChild(_background);
         super.configUI();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_losingStreakIcon)
         {
            ObjectUtils.disposeObject(_losingStreakIcon);
            _losingStreakIcon = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      override protected function drawCells() : void
      {
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:WeaponPropCell = new WeaponPropCell("f",_mode);
         _loc3_.info = new PropInfo(ItemManager.Instance.getTemplateById(10016));
         _loc4_ = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosf");
         _loc3_.setPossiton(_loc4_.x,_loc4_.y);
         addChild(_loc3_);
         var _loc2_:WeaponPropCell = new WeaponPropCell("r",_mode);
         _loc4_ = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosr");
         _loc2_.setPossiton(_loc4_.x,_loc4_.y);
         addChild(_loc2_);
         if(_self.hasDeputyWeapon())
         {
            _loc1_ = _self.currentDeputyWeaponInfo.Template;
            if(_loc1_.TemplateID == 17200)
            {
               _loc1_.Property4 = _self.wishKingEnergy.toString();
               _self.currentDeputyWeaponInfo.energy = _self.wishKingEnergy;
               _loc2_.info = new PropInfo(_loc1_);
               _loc2_.setCount(_self.wishKingCount);
            }
            else
            {
               _loc2_.info = new PropInfo(_loc1_);
               _loc2_.setCount(_self.deputyWeaponCount);
            }
         }
         _cells.push(_loc3_);
         _cells.push(_loc2_);
         super.drawCells();
      }
      
      override protected function removeEvent() : void
      {
         _self.removeEventListener("flyChanged",__flyChanged);
         _self.removeEventListener("deputyweapin_Changed",__deputyWeaponChanged);
         _self.removeEventListener("attackingChanged",__changeAttack);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("click",__itemClicked);
         }
         super.removeEvent();
      }
      
      public function setFlyVisible(param1:Boolean) : void
      {
         if(_localFlyVisible != param1)
         {
            _localFlyVisible = param1;
            if(_localFlyVisible)
            {
               if(!_cells[0].parent)
               {
                  addChild(_cells[0]);
               }
            }
            else if(_cells[0].parent)
            {
               _cells[0].parent.removeChild(_cells[0]);
            }
         }
      }
      
      public function setFlyEnabled(param1:Boolean) : void
      {
         if(_localFlyEnabled != param1)
         {
            _localFlyEnabled = param1;
         }
      }
      
      public function setDeputyWeaponVisible(param1:Boolean) : void
      {
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 18)
         {
            return;
         }
         if(_localDeputyWeaponVisible != param1)
         {
            _localDeputyWeaponVisible = param1;
            if(_localDeputyWeaponVisible)
            {
               if(!_cells[1].parent)
               {
                  addChild(_cells[1]);
               }
            }
            else if(_cells[1].parent)
            {
               _cells[1].parent.removeChild(_cells[1]);
            }
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         _localVisible = param1;
      }
   }
}
