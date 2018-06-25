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
      
      public function WeaponPropBar(self:LocalPlayer)
      {
         super(self);
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
         var tmp:ConsortiaBattlePlayerInfo = ConsortiaBattleManager.instance.getPlayerInfo(PlayerManager.Instance.Self.ID);
         if(tmp.failBuffCount > 0)
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
         var roomType:int = 0;
         var template:ItemTemplateInfo = _self.currentDeputyWeaponInfo.Template;
         if(template.TemplateID == 17200)
         {
            roomType = RoomManager.Instance.current.type;
            if(roomType == 4 || roomType == 11 || roomType == 21 || roomType == 14 || roomType == 123 || roomType == 151 || StateManager.currentStateType == "fightLabGameView")
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
      
      override protected function __itemClicked(event:MouseEvent) : void
      {
         var result:* = null;
         if(!_localVisible)
         {
            return;
         }
         var cell:PropCell = event.currentTarget as PropCell;
         SoundManager.instance.play("008");
         var idx:int = _cells.indexOf(cell);
         switch(int(idx))
         {
            case 0:
               if(!_localFlyEnabled || !_localFlyVisible)
               {
                  return;
               }
               result = _self.useFly();
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
               result = _self.useDeputyWeapon();
               break;
         }
         if(result == "2")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.NotCoolDown",_self.flyCoolDown));
         }
         else if(result == "4")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.NotCoolDown",_self.deputyWeaponCoolDown));
         }
         else if(result == "5")
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
                           addr199:
                        }
                        addr127:
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.deputyWeapon.canNotUse"));
                        §§goto(addr199);
                     }
                     addr126:
                     §§goto(addr127);
                  }
                  addr125:
                  §§goto(addr126);
               }
               addr124:
               §§goto(addr125);
            }
            §§goto(addr124);
         }
         else if(result != "0")
         {
            if(result != "LockState" || RoomManager.Instance.current.type != 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + result));
            }
         }
         else if(idx == 0)
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
      
      override protected function __keyDown(event:KeyboardEvent) : void
      {
         if(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI)
         {
            return;
         }
         var _loc2_:* = event.keyCode;
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
         super.__keyDown(event);
      }
      
      override protected function addEvent() : void
      {
         _self.addEventListener("flyChanged",__flyChanged);
         _self.addEventListener("deputyweapin_Changed",__deputyWeaponChanged);
         _self.addEventListener("attackingChanged",__changeAttack);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.addEventListener("click",__itemClicked);
         }
         super.addEvent();
      }
      
      override protected function __changeAttack(event:LivingEvent) : void
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
      
      private function __setDeputyWeaponNumber(event:CrazyTankSocketEvent) : void
      {
         var count:int = event.pkg.readInt();
         _cells[1].enabled = count != 0;
         WeaponPropCell(_cells[1]).setCount(count);
      }
      
      private function __deputyWeaponChanged(event:LivingEvent) : void
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
      
      private function __flyChanged(event:LivingEvent) : void
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
         var pos:* = null;
         var template:* = null;
         var cellf:WeaponPropCell = new WeaponPropCell("f",_mode);
         cellf.info = new PropInfo(ItemManager.Instance.getTemplateById(10016));
         pos = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosf");
         cellf.setPossiton(pos.x,pos.y);
         addChild(cellf);
         var cellr:WeaponPropCell = new WeaponPropCell("r",_mode);
         pos = ComponentFactory.Instance.creatCustomObject("WeaponPropCellPosr");
         cellr.setPossiton(pos.x,pos.y);
         addChild(cellr);
         if(_self.hasDeputyWeapon())
         {
            template = _self.currentDeputyWeaponInfo.Template;
            if(template.TemplateID == 17200)
            {
               template.Property4 = _self.wishKingEnergy.toString();
               _self.currentDeputyWeaponInfo.energy = _self.wishKingEnergy;
               cellr.info = new PropInfo(template);
               cellr.setCount(_self.wishKingCount);
            }
            else
            {
               cellr.info = new PropInfo(template);
               cellr.setCount(_self.deputyWeaponCount);
            }
         }
         _cells.push(cellf);
         _cells.push(cellr);
         super.drawCells();
      }
      
      override protected function removeEvent() : void
      {
         _self.removeEventListener("flyChanged",__flyChanged);
         _self.removeEventListener("deputyweapin_Changed",__deputyWeaponChanged);
         _self.removeEventListener("attackingChanged",__changeAttack);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("click",__itemClicked);
         }
         super.removeEvent();
      }
      
      public function setFlyVisible(val:Boolean) : void
      {
         if(_localFlyVisible != val)
         {
            _localFlyVisible = val;
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
      
      public function setFlyEnabled(val:Boolean) : void
      {
         if(_localFlyEnabled != val)
         {
            _localFlyEnabled = val;
         }
      }
      
      public function setDeputyWeaponVisible(val:Boolean) : void
      {
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 18)
         {
            return;
         }
         if(_localDeputyWeaponVisible != val)
         {
            _localDeputyWeaponVisible = val;
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
      
      public function setVisible(val:Boolean) : void
      {
         _localVisible = val;
      }
   }
}
