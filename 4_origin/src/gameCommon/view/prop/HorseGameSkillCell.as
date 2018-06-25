package gameCommon.view.prop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.horse.HorseSkillCell;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import gameCommon.model.LocalPlayer;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import room.RoomManager;
   
   public class HorseGameSkillCell extends Sprite implements Disposeable
   {
      
      public static const CELL_CLICKED:String = "cell_clicked";
       
      
      private var _skillId:int;
      
      private var _shortcutKey:String;
      
      private var _skillCell:HorseSkillCell;
      
      private var _countTxt:FilterFrameText;
      
      private var _grayCoverSprite:Sprite;
      
      private var _coldDownTxt:FilterFrameText;
      
      private var _lastUpClickTime:int = 0;
      
      private var _grayFilter:Array;
      
      private var _isCanUse:Boolean = true;
      
      private var _isAttacking:Boolean = false;
      
      private var _needColdNum:int = -1;
      
      private var _coldNum:int;
      
      private var _self:LocalPlayer;
      
      private var _enabled:Boolean = false;
      
      private var _skillInfo:HorseSkillVo;
      
      private var _isCanUse2:Boolean = true;
      
      private var _suicideSkill:int = 20090;
      
      public function HorseGameSkillCell(skillId:int, shortcutKey:String, self:LocalPlayer)
      {
         super();
         _skillId = skillId;
         _shortcutKey = shortcutKey;
         _self = self;
         _grayFilter = ComponentFactory.Instance.creatFilters("grayFilter");
         if(_skillId > 0)
         {
            _skillInfo = HorseManager.instance.getHorseSkillInfoById(_skillId);
            _needColdNum = _skillInfo.ColdDown;
            this.buttonMode = true;
         }
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var back:Bitmap = ComponentFactory.Instance.creatBitmap("asset.game.prop.ItemBack");
         addChild(back);
         if(_skillId > 0)
         {
            _skillCell = new HorseSkillCell(_skillId,false,true);
            _skillCell.x = -3;
            _skillCell.y = -3;
            addChild(_skillCell);
         }
         var fore:Bitmap = ComponentFactory.Instance.creatBitmap("asset.game.prop.ItemFore");
         var _loc4_:int = 2;
         fore.y = _loc4_;
         fore.x = _loc4_;
         addChild(fore);
         if(_skillId > 0)
         {
            _grayCoverSprite = new Sprite();
            _grayCoverSprite.graphics.beginFill(0,0.5);
            _grayCoverSprite.graphics.drawRect(back.x,back.y,back.width,back.height);
            _grayCoverSprite.graphics.endFill();
            _grayCoverSprite.mouseChildren = false;
            _grayCoverSprite.mouseEnabled = false;
            addChild(_grayCoverSprite);
            _coldDownTxt = ComponentFactory.Instance.creatComponentByStylename("game.horseGameSkillCell.coldDownTxt");
            addChild(_coldDownTxt);
            _grayCoverSprite.visible = false;
            _coldDownTxt.visible = false;
         }
         var shortcutKeyImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.game.prop.ShortcutKey" + _shortcutKey);
         shortcutKeyImg.y = -2;
         addChild(shortcutKeyImg);
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("game.customPropCell.countTxt");
         if(_skillId > 0)
         {
            _countTxt.visible = true;
            _countTxt.text = _skillInfo.UseCount.toString();
         }
         else
         {
            _countTxt.visible = false;
         }
         addChild(_countTxt);
      }
      
      private function initEvent() : void
      {
         if(_skillCell)
         {
            addEventListener("click",__clicked);
         }
      }
      
      public function useSkill() : void
      {
         if(_skillId > 0)
         {
            __clicked(null);
         }
      }
      
      private function __clicked(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         StageReferance.stage.focus = null;
         if(RoomManager.Instance.current.type == 18 && isForbiddenSkill(skillId))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("room.view.roomView.FightRoom.HorseSkillForbidden"),0,false,1);
            return;
         }
         if(!_isCanUse2)
         {
            return;
         }
         if(!_enabled)
         {
            return;
         }
         if(!_isCanUse)
         {
            return;
         }
         if(!_isAttacking)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.NotAttacking"));
            return;
         }
         if(_self.LockState)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.lockState.cannotUseSkill"));
            return;
         }
         if(_self.energy < _skillInfo.CostEnergy)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.EmptyEnergy"));
            return;
         }
         if(getTimer() - _lastUpClickTime <= 1000)
         {
            return;
         }
         if(_skillInfo.BallType == 1)
         {
            if(_self.isUsedItem)
            {
               return;
            }
            _self.flyEnabled = false;
            _self.deputyWeaponEnabled = false;
            _self.rightPropEnabled = false;
            _self.spellKillEnabled = false;
            _self.isUsedPetSkillWithNoItem = true;
         }
         _lastUpClickTime = getTimer();
         SocketManager.Instance.out.sendPetSkill(_skillId,2);
         dispatchEvent(new Event("cell_clicked"));
         setEnable(false);
         _self.energy = _self.energy - skillInfo.CostEnergy;
      }
      
      private function isForbiddenSkill(skillId:int) : Boolean
      {
         var _loc2_:* = skillId;
         if(11101 !== _loc2_)
         {
            if(11102 !== _loc2_)
            {
               if(11103 !== _loc2_)
               {
                  if(11104 !== _loc2_)
                  {
                     if(11105 !== _loc2_)
                     {
                        if(11106 !== _loc2_)
                        {
                           if(11107 !== _loc2_)
                           {
                              if(11108 !== _loc2_)
                              {
                                 if(11109 !== _loc2_)
                                 {
                                    if(11110 !== _loc2_)
                                    {
                                       if(11301 !== _loc2_)
                                       {
                                          if(11302 !== _loc2_)
                                          {
                                             if(11303 !== _loc2_)
                                             {
                                                if(11304 !== _loc2_)
                                                {
                                                   if(11305 !== _loc2_)
                                                   {
                                                      if(11306 !== _loc2_)
                                                      {
                                                         if(11307 !== _loc2_)
                                                         {
                                                            if(11308 !== _loc2_)
                                                            {
                                                               if(11309 !== _loc2_)
                                                               {
                                                                  if(11310 !== _loc2_)
                                                                  {
                                                                     if(10301 !== _loc2_)
                                                                     {
                                                                        if(10302 !== _loc2_)
                                                                        {
                                                                           if(10303 !== _loc2_)
                                                                           {
                                                                              if(10304 !== _loc2_)
                                                                              {
                                                                                 if(10305 !== _loc2_)
                                                                                 {
                                                                                    if(10306 !== _loc2_)
                                                                                    {
                                                                                       if(10307 !== _loc2_)
                                                                                       {
                                                                                          if(10308 !== _loc2_)
                                                                                          {
                                                                                             if(10309 !== _loc2_)
                                                                                             {
                                                                                                if(10310 !== _loc2_)
                                                                                                {
                                                                                                   return false;
                                                                                                }
                                                                                             }
                                                                                             addr37:
                                                                                             return true;
                                                                                          }
                                                                                          addr36:
                                                                                          §§goto(addr37);
                                                                                       }
                                                                                       addr35:
                                                                                       §§goto(addr36);
                                                                                    }
                                                                                    addr34:
                                                                                    §§goto(addr35);
                                                                                 }
                                                                                 addr33:
                                                                                 §§goto(addr34);
                                                                              }
                                                                              addr32:
                                                                              §§goto(addr33);
                                                                           }
                                                                           addr31:
                                                                           §§goto(addr32);
                                                                        }
                                                                        addr30:
                                                                        §§goto(addr31);
                                                                     }
                                                                     addr29:
                                                                     §§goto(addr30);
                                                                  }
                                                                  addr28:
                                                                  §§goto(addr29);
                                                               }
                                                               addr27:
                                                               §§goto(addr28);
                                                            }
                                                            addr26:
                                                            §§goto(addr27);
                                                         }
                                                         addr25:
                                                         §§goto(addr26);
                                                      }
                                                      addr24:
                                                      §§goto(addr25);
                                                   }
                                                   addr23:
                                                   §§goto(addr24);
                                                }
                                                addr22:
                                                §§goto(addr23);
                                             }
                                             addr21:
                                             §§goto(addr22);
                                          }
                                          addr20:
                                          §§goto(addr21);
                                       }
                                       addr19:
                                       §§goto(addr20);
                                    }
                                    addr18:
                                    §§goto(addr19);
                                 }
                                 addr17:
                                 §§goto(addr18);
                              }
                              addr16:
                              §§goto(addr17);
                           }
                           addr15:
                           §§goto(addr16);
                        }
                        addr14:
                        §§goto(addr15);
                     }
                     addr13:
                     §§goto(addr14);
                  }
                  addr12:
                  §§goto(addr13);
               }
               addr11:
               §§goto(addr12);
            }
            addr10:
            §§goto(addr11);
         }
         §§goto(addr10);
      }
      
      private function setEnable(value:Boolean) : void
      {
         _isCanUse = value;
         if(_isCanUse && _enabled && _isCanUse2)
         {
            _skillCell.filters = null;
         }
         else
         {
            _skillCell.filters = _grayFilter;
         }
      }
      
      public function get skillId() : int
      {
         return _skillId;
      }
      
      public function setColdCount(cd:int, count:int) : void
      {
         var restCount:int = _skillInfo.UseCount - count;
         _countTxt.text = restCount.toString();
         if(restCount > 0)
         {
            _coldNum = cd;
            if(_coldNum > 0)
            {
               setEnable(false);
               coldDownShowHide(true);
            }
         }
         else
         {
            setEnable(false);
         }
      }
      
      public function useCompleteHandler(isUse:Boolean, restCount:int) : void
      {
         if(isUse)
         {
            setEnable(false);
            _countTxt.text = restCount.toString();
            if(restCount > 0)
            {
               _coldNum = _needColdNum + 1;
               coldDownShowHide(true);
            }
         }
         else
         {
            setEnable(true);
         }
      }
      
      public function attackChangeHandler(isAttacking:Boolean) : void
      {
         if(!_skillCell)
         {
            return;
         }
         _isAttacking = isAttacking;
         if(_isAttacking)
         {
            isCanUse2 = true;
         }
      }
      
      public function roundOneEndHandler() : void
      {
         if(!_skillCell)
         {
            return;
         }
         if(_coldNum > 0)
         {
            _coldNum = Number(_coldNum) - 1;
            if(_coldNum <= 0)
            {
               setEnable(true);
               coldDownShowHide(false);
            }
            else
            {
               coldDownShowHide(true);
            }
         }
      }
      
      private function coldDownShowHide(isShow:Boolean) : void
      {
         _grayCoverSprite.visible = isShow;
         _coldDownTxt.visible = isShow;
         _coldDownTxt.text = Math.min(_coldNum,_needColdNum).toString();
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(val:Boolean) : void
      {
         if(!_skillCell)
         {
            return;
         }
         if(_enabled != val)
         {
            _enabled = val;
            if(isSuicideSkill && _enabled && !suicideSkillCanUse)
            {
               _enabled = false;
               _skillCell.filters = _grayFilter;
               return;
            }
            if(_enabled && _isCanUse && _isCanUse2)
            {
               _skillCell.filters = null;
            }
            else
            {
               _skillCell.filters = _grayFilter;
            }
         }
      }
      
      private function get suicideSkillCanUse() : Boolean
      {
         return _self.blood <= _self.maxBlood / 2?true:false;
      }
      
      private function get isSuicideSkill() : Boolean
      {
         return _skillId == _suicideSkill;
      }
      
      public function get isCanUse2() : Boolean
      {
         return _isCanUse2;
      }
      
      public function set isCanUse2(val:Boolean) : void
      {
         if(!_skillCell)
         {
            return;
         }
         if(_isCanUse2 != val)
         {
            _isCanUse2 = val;
            if(_isCanUse2 && _isCanUse && _enabled)
            {
               _skillCell.filters = null;
            }
            else
            {
               _skillCell.filters = _grayFilter;
            }
         }
      }
      
      public function get skillInfo() : HorseSkillVo
      {
         return _skillInfo;
      }
      
      private function removeEvent() : void
      {
         if(_skillCell)
         {
            removeEventListener("click",__clicked);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _skillCell = null;
         _countTxt = null;
         _coldDownTxt = null;
         _grayCoverSprite = null;
         _grayFilter = null;
         _self = null;
         _skillInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
