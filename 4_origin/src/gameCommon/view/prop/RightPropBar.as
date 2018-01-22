package gameCommon.view.prop
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.DragManager;
   import ddt.manager.InGameCursor;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MaxBtnStateManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import game.GameDecorateManager;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.control.LiveState;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import room.RoomManager;
   import trainer.controller.WeakGuildManager;
   import trainer.view.NewHandContainer;
   
   public class RightPropBar extends FightPropBar
   {
      
      private static var oneTwoThreeSkill:Array = [10001,10003,10002];
       
      
      private var _startPos:Point;
      
      private var _mouseHolded:Boolean = false;
      
      private var _elasped:int = 0;
      
      private var _last:int = 0;
      
      private var _container:DisplayObjectContainer;
      
      private var _localVisible:Boolean = true;
      
      private var _tweenComplete:Boolean = true;
      
      private var _rightPropBarBorder:Array;
      
      private var _cellSprite:Sprite;
      
      private var cell:PropCell;
      
      private var _tempPlace:int;
      
      private var _maxBtn:PropMaxBtn;
      
      private var _packUpBtn:SimpleBitmapButton;
      
      private var _dropDownBtn:SimpleBitmapButton;
      
      private var _isPackUp:Boolean = false;
      
      private var _greyFilter:Array;
      
      private var bmp:Bitmap;
      
      public function RightPropBar(param1:LocalPlayer, param2:DisplayObjectContainer)
      {
         _rightPropBarBorder = [];
         _rightPropBarBorder.push(GameDecorateManager.Instance.createBitmapUI(this,"asset.gameDecorate.rightPropBarBg1"));
         _rightPropBarBorder.push(GameDecorateManager.Instance.createBitmapUI(this,"asset.gameDecorate.rightPropBarBg2"));
         isPackUp = false;
         _container = param2;
         super(param1);
         setItems();
         checkArmShellSpring();
      }
      
      private function setPropBarBorder(param1:int, param2:Boolean) : void
      {
         if(_rightPropBarBorder && _rightPropBarBorder[param1])
         {
            _rightPropBarBorder[param1].visible = param2;
         }
      }
      
      public function get isPackUp() : Boolean
      {
         return _isPackUp;
      }
      
      public function set isPackUp(param1:Boolean) : void
      {
         _isPackUp = param1;
         if(_isPackUp)
         {
            setPropBarBorder(0,false);
            setPropBarBorder(1,true);
         }
         else
         {
            setPropBarBorder(0,true);
            setPropBarBorder(1,false);
         }
      }
      
      override public function set x(param1:Number) : void
      {
         .super.x = param1;
      }
      
      private function addEvents() : void
      {
         MaxBtnStateManager.getInstance().addEvents();
         MaxBtnStateManager.getInstance().addEventListener("maxbtnstate_change",onMaxBtnStateChange);
      }
      
      protected function onMaxBtnStateChange(param1:Event) : void
      {
         var _loc2_:* = MaxBtnStateManager.getInstance().maxBtnIsPackUp;
         if(true !== _loc2_)
         {
            if(false === _loc2_)
            {
               dropDownEffect();
            }
         }
         else
         {
            packUpEffect();
         }
      }
      
      public function setup(param1:DisplayObjectContainer) : void
      {
         _container = param1;
         _container.addChild(this);
         if(PlayerManager.Instance.Self.Grade >= 16)
         {
            this.y = this.y - 8;
         }
         if(_mode == 2)
         {
            x = _background.width;
            if(SharedManager.Instance.propTransparent)
            {
               TweenLite.to(this,0.3,{
                  "x":0,
                  "alpha":0.5
               });
            }
            else
            {
               TweenLite.to(this,0.3,{
                  "x":0,
                  "alpha":1
               });
            }
         }
         else
         {
            y = 102;
            if(SharedManager.Instance.propTransparent)
            {
               TweenLite.to(this,0.3,{
                  "y":0,
                  "alpha":0.5
               });
            }
            else
            {
               TweenLite.to(this,0.3,{
                  "y":0,
                  "alpha":1
               });
            }
         }
      }
      
      protected function setItems() : void
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc1_:Boolean = false;
         var _loc5_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(10200,true,true);
         var _loc3_:Object = SharedManager.Instance.GameKeySets;
         var _loc11_:int = 0;
         var _loc10_:* = _loc3_;
         for(var _loc4_ in _loc3_)
         {
            if(int(_loc4_) != 9)
            {
               _loc7_ = new PropInfo(ItemManager.Instance.getTemplateById(_loc3_[_loc4_]));
               if(_loc5_ || PlayerManager.Instance.Self.hasBuff(15))
               {
                  if(_loc5_)
                  {
                     _loc7_.Place = _loc5_.Place;
                  }
                  else
                  {
                     _loc7_.Place = -1;
                  }
                  _loc7_.Count = -1;
                  _cells[int(_loc4_) - 1].info = _loc7_;
                  _loc1_ = true;
               }
               else
               {
                  _loc2_ = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_loc3_[_loc4_]);
                  if(_loc2_.length > 0)
                  {
                     _loc7_.Place = _loc2_[0].Place;
                     var _loc9_:int = 0;
                     var _loc8_:* = _loc2_;
                     for each(var _loc6_ in _loc2_)
                     {
                        _loc7_.Count = _loc7_.Count + _loc6_.Count;
                     }
                     _cells[int(_loc4_) - 1].info = _loc7_;
                     _loc1_ = true;
                  }
                  else
                  {
                     _cells[int(_loc4_) - 1].info = _loc7_;
                  }
               }
               continue;
            }
            break;
         }
         if(_loc1_)
         {
            handleItem();
         }
      }
      
      private function checkArmShellSpring() : void
      {
         var _loc1_:* = null;
         if(GameControl.Instance.Current.roomType == 120 || GameControl.Instance.Current.roomType == 123)
         {
            _loc1_ = PlayerManager.Instance.Self.Bag.getItemAt(20);
            if(_loc1_ && EquipType.isArmShellSpring(_loc1_))
            {
               var _loc4_:int = 0;
               var _loc3_:* = _cells;
               for each(var _loc2_ in _cells)
               {
                  if(_loc2_.info.TemplateID == 10003)
                  {
                     _loc2_.enabled = false;
                     break;
                  }
               }
            }
         }
      }
      
      private function clickPropArmShellTotem(param1:int) : void
      {
         if(GameControl.Instance.Current)
         {
            if(GameControl.Instance.Current.roomType == 120 || GameControl.Instance.Current.roomType == 123)
            {
               if(oneTwoThreeSkill.indexOf(param1) != -1)
               {
                  _self.totemEnabled = false;
                  if(!_self.totemEnabled)
                  {
                     _self.spellKillEnabled = false;
                  }
               }
            }
         }
      }
      
      protected function handleItem() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Grade >= 16)
         {
            _greyFilter = ComponentFactory.Instance.creatFilters("grayFilter");
            _maxBtn = new PropMaxBtn();
            bmp = ComponentFactory.Instance.creat("asset.game.prop.Max");
            bmp.smoothing = true;
            bmp.width = 37;
            bmp.height = 37;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.game.prop.ShortcutKey4");
            _loc1_.x = 23;
            _loc1_.y = -1;
            _maxBtn.addChild(bmp);
            _maxBtn.addChild(_loc1_);
            PositionUtils.setPos(_maxBtn,"prop.maxbtn");
            _maxBtn.addEventListener("mouseOver",onMaxOver);
            _maxBtn.addEventListener("mouseOut",onMaxOut);
            _packUpBtn = ComponentFactory.Instance.creat("prop.packUpBtn");
            _dropDownBtn = ComponentFactory.Instance.creat("prop.dropDwonBtn");
            addChild(_packUpBtn);
            _packUpBtn.addEventListener("click",onPackUpClick);
            _dropDownBtn.addEventListener("click",onDropDownClick);
            addEvents();
            MaxBtnStateManager.getInstance().requireState();
         }
         updatePropByEnergy();
         if(_self.autoOnHook)
         {
            _packUpBtn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      protected function onMaxOut(param1:MouseEvent) : void
      {
         _maxBtn.scaleX = 1;
         _maxBtn.x = _maxBtn.x + 3;
         _maxBtn.scaleY = 1;
         TweenMax.killTweensOf(_maxBtn);
         _maxBtn.filters = [];
      }
      
      protected function onMaxOver(param1:MouseEvent) : void
      {
         _maxBtn.scaleX = 1.1;
         _maxBtn.x = _maxBtn.x - 3;
         _maxBtn.scaleY = 1.1;
         if(!TweenMax.isTweening(_maxBtn))
         {
            TweenMax.to(_maxBtn,0.5,{
               "repeat":-1,
               "yoyo":true,
               "glowFilter":{
                  "color":16777011,
                  "alpha":1,
                  "blurX":4,
                  "blurY":4,
                  "strength":3
               }
            });
         }
      }
      
      override protected function updatePropByEnergy() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            if(_loc1_.info)
            {
               _loc2_ = _loc1_.info;
               if(_loc2_)
               {
                  if(_self.energy < _loc2_.needEnergy)
                  {
                     _loc1_.enabled = false;
                     clearArrowByProp(_loc2_,false,true);
                  }
                  else if(!_self.twoKillEnabled && (_loc1_.info.TemplateID == 10001 || _loc1_.info.TemplateID == 10002 || _loc1_.info.TemplateID == 10003))
                  {
                     _loc1_.enabled = false;
                  }
                  else if(!_self.totemEnabled && oneTwoThreeSkill.indexOf(_loc1_.info.TemplateID) != -1)
                  {
                     _loc1_.enabled = false;
                  }
                  else if(_loc1_.info.TemplateID == 10003)
                  {
                     _loc1_.enabled = _self.threeKillEnabled;
                  }
                  else
                  {
                     _loc1_.enabled = true;
                  }
               }
            }
         }
         checkMaxFilter();
      }
      
      private function checkMaxFilter() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(_maxBtn)
         {
            _maxBtn.mouseEnabled = false;
            _loc1_ = _greyFilter;
            _loc2_ = 3;
            while(_loc2_ < _cells.length)
            {
               if(_cells[_loc2_].enabled)
               {
                  _loc1_ = [];
                  _maxBtn.mouseEnabled = true;
                  break;
               }
               _loc2_++;
            }
            bmp.filters = _loc1_;
         }
      }
      
      private function clearArrowByProp(param1:PropInfo, param2:Boolean = true, param3:Boolean = false) : void
      {
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return;
         }
         switch(int(param1.TemplateID) - 10002)
         {
            case 0:
               clearArr(20,param2);
               break;
            case 1:
               clearArr(21,param2);
               if(!param3)
               {
                  clearArr(18,param2);
               }
               break;
            default:
               clearArr(21,param2);
               if(!param3)
               {
                  clearArr(18,param2);
               }
               break;
            default:
               clearArr(21,param2);
               if(!param3)
               {
                  clearArr(18,param2);
               }
               break;
            default:
               clearArr(21,param2);
               if(!param3)
               {
                  clearArr(18,param2);
               }
               break;
            default:
               clearArr(21,param2);
               if(!param3)
               {
                  clearArr(18,param2);
               }
               break;
            case 6:
               clearArr(19,param2);
         }
      }
      
      private function clearArr(param1:int, param2:Boolean) : void
      {
         if(NewHandContainer.Instance.hasArrow(param1))
         {
            NewHandContainer.Instance.clearArrowByID(param1);
            if(param2)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.view.propContainer.ItemContainer.energy"));
            }
         }
      }
      
      override protected function __itemClicked(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!_localVisible)
         {
            return;
         }
         if(_enabled)
         {
            if(_self.isUsedPetSkillWithNoItem)
            {
               return;
            }
            _self.isUsedItem = true;
            _loc3_ = param1.currentTarget as PropCell;
            if(!_loc3_.enabled)
            {
               return;
            }
            SoundManager.instance.play("008");
            _loc2_ = _self.useProp(_loc3_.info,1);
            if(_loc2_ != "-1" && _loc2_ != "0")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + _loc2_));
            }
            else if(_loc2_ == "-1")
            {
               clearArrowByProp(_loc3_.info);
            }
            super.__itemClicked(param1);
            if(!_self.autoOnHook)
            {
               StageReferance.stage.focus = null;
            }
         }
      }
      
      override protected function addEvent() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.addEventListener("click",__itemClicked);
            _loc1_.addEventListener("mouseDown",__DownItemHandler);
         }
         _self.addEventListener("threekillChanged",__threeKillChanged);
         _self.addEventListener("rightenabledChanged",__rightEnabledChanged);
         _self.addEventListener("usingItem",__usingItem);
         _self.addEventListener("shoot",__shoot);
         _self.addEventListener("attackingChanged",__attackingChanged);
         _self.addEventListener("setEnable",__setEnable);
         SharedManager.Instance.addEventListener("transparentChanged",__transparentChanged);
         super.addEvent();
      }
      
      private function __setEnable(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc2_ in _cells)
         {
            if(_loc2_.info.TemplateID == 10001)
            {
               _loc2_.enabled = false;
            }
            if(_loc2_.info.TemplateID == 10003)
            {
               _loc2_.enabled = false;
            }
            if(_loc2_.info.TemplateID == 10002)
            {
               _loc2_.enabled = false;
            }
         }
      }
      
      protected function __transparentChanged(param1:Event) : void
      {
         if(_tweenComplete && parent)
         {
            if(SharedManager.Instance.propTransparent)
            {
               alpha = 0.5;
            }
            else
            {
               alpha = 1;
            }
         }
      }
      
      private function __attackingChanged(param1:LivingEvent) : void
      {
         if(_self.isAttacking && parent == null && _localVisible)
         {
            TweenLite.killTweensOf(this,true);
            addChildToContainer();
            if(_mode == 2)
            {
               alpha = 0;
               x = _background.width;
               if(SharedManager.Instance.propTransparent)
               {
                  TweenLite.to(this,0.3,{
                     "x":0,
                     "alpha":0.5,
                     "onComplete":showComplete
                  });
               }
               else
               {
                  TweenLite.to(this,0.3,{
                     "x":0,
                     "alpha":1,
                     "onComplete":showComplete
                  });
               }
               _tweenComplete = false;
            }
            else
            {
               if(SharedManager.Instance.propTransparent)
               {
                  alpha = 0.5;
               }
               else
               {
                  alpha = 1;
               }
               x = 0;
               TweenLite.to(this,0.3,{"x":0});
            }
         }
         else if(!_self.isAttacking)
         {
            if(PlayerManager.Instance.Self.Grade > 15)
            {
               if(parent)
               {
                  hide();
               }
            }
         }
      }
      
      private function showComplete() : void
      {
         _tweenComplete = true;
      }
      
      private function hide() : void
      {
         TweenLite.killTweensOf(cell);
         DragManager.__upDrag(null);
         InGameCursor.show();
         _tweenComplete = false;
         TweenLite.to(this,0.3,{
            "alpha":0,
            "onComplete":hideComplete
         });
      }
      
      private function hideComplete() : void
      {
         _tweenComplete = true;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __shoot(param1:LivingEvent) : void
      {
         if(PlayerManager.Instance.Self.Grade > 15)
         {
            if(parent)
            {
               TweenLite.killTweensOf(this,true);
               hide();
            }
         }
      }
      
      override protected function __enabledChanged(param1:LivingEvent) : void
      {
         enabled = _self.propEnabled && _self.rightPropEnabled;
         checkArmShellSpring();
      }
      
      private function __rightEnabledChanged(param1:LivingEvent) : void
      {
         enabled = _self.propEnabled && _self.rightPropEnabled;
         checkArmShellSpring();
      }
      
      private function __usingItem(param1:LivingEvent) : void
      {
         var _loc2_:* = null;
         if(param1.paras[0] is ItemTemplateInfo)
         {
            _loc2_ = param1.paras[0] as ItemTemplateInfo;
            clickPropArmShellTotem(_loc2_.TemplateID);
         }
      }
      
      private function __threeKillChanged(param1:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc2_ in _cells)
         {
            if(!_self.totemEnabled && oneTwoThreeSkill.indexOf(_loc2_.info.TemplateID) != -1)
            {
               _loc2_.enabled = false;
            }
            else if(_loc2_.info.TemplateID == 10003)
            {
               _loc2_.enabled = _self.threeKillEnabled;
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(_enabled != param1)
         {
            _enabled = param1;
            if(_enabled)
            {
               _cellSprite.filters = null;
               updatePropByEnergy();
            }
            else
            {
               _cellSprite.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
            }
            var _loc4_:int = 0;
            var _loc3_:* = _cells;
            for each(var _loc2_ in _cells)
            {
               if(_loc2_.info.TemplateID == 10003)
               {
                  _loc2_.enabled = _self.threeKillEnabled;
               }
               else
               {
                  _loc2_.enabled = _enabled;
               }
            }
         }
      }
      
      override protected function __keyDown(param1:KeyboardEvent) : void
      {
         if(!_enabled || GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI || RoomManager.Instance.current.type == 41 || RoomManager.Instance.current.type == 42 || GameControl.Instance.Current.mapIndex == 1405)
         {
            return;
         }
         if(_self.isAttacking == false)
         {
            return;
         }
         var _loc2_:* = param1.keyCode;
         if(KeyStroke.VK_1.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_NUMPAD_1.getCode() !== _loc2_)
            {
               if(KeyStroke.VK_2.getCode() !== _loc2_)
               {
                  if(KeyStroke.VK_NUMPAD_2.getCode() !== _loc2_)
                  {
                     if(KeyStroke.VK_3.getCode() !== _loc2_)
                     {
                        if(KeyStroke.VK_NUMPAD_3.getCode() !== _loc2_)
                        {
                           if(KeyStroke.VK_4.getCode() !== _loc2_)
                           {
                              if(KeyStroke.VK_NUMPAD_4.getCode() !== _loc2_)
                              {
                                 if(KeyStroke.VK_5.getCode() !== _loc2_)
                                 {
                                    if(KeyStroke.VK_NUMPAD_5.getCode() !== _loc2_)
                                    {
                                       if(KeyStroke.VK_6.getCode() !== _loc2_)
                                       {
                                          if(KeyStroke.VK_NUMPAD_6.getCode() !== _loc2_)
                                          {
                                             if(KeyStroke.VK_7.getCode() !== _loc2_)
                                             {
                                                if(KeyStroke.VK_NUMPAD_7.getCode() !== _loc2_)
                                                {
                                                   if(KeyStroke.VK_8.getCode() !== _loc2_)
                                                   {
                                                      if(KeyStroke.VK_NUMPAD_8.getCode() !== _loc2_)
                                                      {
                                                      }
                                                   }
                                                   if(!isPackUp)
                                                   {
                                                      _cells[7].useProp();
                                                   }
                                                }
                                             }
                                             if(!isPackUp)
                                             {
                                                _cells[6].useProp();
                                             }
                                          }
                                       }
                                       if(!isPackUp)
                                       {
                                          _cells[5].useProp();
                                       }
                                    }
                                 }
                                 if(!isPackUp)
                                 {
                                    _cells[4].useProp();
                                 }
                              }
                           }
                           if(isPackUp)
                           {
                              useMaxBtn();
                           }
                           else
                           {
                              _cells[3].useProp();
                           }
                        }
                     }
                     _cells[2].useProp();
                  }
               }
               _cells[1].useProp();
            }
            addr211:
            return;
         }
         _cells[0].useProp();
         §§goto(addr211);
      }
      
      override protected function configUI() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("RightPropBack");
         addChild(_background);
         super.configUI();
      }
      
      override protected function drawCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cellSprite = new Sprite();
         addChild(_cellSprite);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new PropCell(String(_loc2_ + 1),_mode,true);
            _loc1_.addEventListener("click",__itemClicked);
            _loc1_.addEventListener("mouseDown",__DownItemHandler);
            _cellSprite.addChild(_loc1_);
            _cells.push(_loc1_);
            _loc2_++;
         }
         drawLayer();
      }
      
      private function __DownItemHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(5) && PlayerManager.Instance.Self.IsWeakGuildFinish(2) && PlayerManager.Instance.Self.IsWeakGuildFinish(12) && PlayerManager.Instance.Self.IsWeakGuildFinish(51) && PlayerManager.Instance.Self.IsWeakGuildFinish(55) && _tweenComplete == true)
         {
            cell = param1.currentTarget as PropCell;
            _tempPlace = _cells.indexOf(cell) + 1;
            _container.addEventListener("mouseUp",__UpItemHandler);
            TweenLite.to(cell,0.5,{"onComplete":OnCellComplete});
         }
      }
      
      private function OnCellComplete() : void
      {
         KeyboardManager.getInstance().isStopDispatching = true;
         cell.dragStart();
      }
      
      private function __UpItemHandler(param1:MouseEvent) : void
      {
         TweenLite.killTweensOf(cell);
         _container.removeEventListener("mouseUp",__UpItemHandler);
      }
      
      override public function dispose() : void
      {
         if(_cellSprite)
         {
            ObjectUtils.disposeAllChildren(_cellSprite);
            ObjectUtils.disposeObject(_cellSprite);
            _cellSprite = null;
         }
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
            _background = null;
         }
         if(_maxBtn != null)
         {
            _maxBtn.removeEventListener("mouseOut",onMaxOut);
            _maxBtn.removeEventListener("mouseOver",onMaxOver);
            ObjectUtils.disposeObject(_maxBtn);
            _maxBtn = null;
         }
         if(_dropDownBtn != null)
         {
            _dropDownBtn.removeEventListener("click",onDropDownClick);
            ObjectUtils.disposeObject(_dropDownBtn);
            _dropDownBtn = null;
         }
         if(_packUpBtn != null)
         {
            _packUpBtn.removeEventListener("click",onPackUpClick);
            ObjectUtils.disposeObject(_packUpBtn);
            _packUpBtn = null;
         }
         super.dispose();
         _rightPropBarBorder = null;
      }
      
      override protected function removeEvent() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("click",__itemClicked);
            _loc1_.removeEventListener("mouseDown",__DownItemHandler);
         }
         _self.removeEventListener("threekillChanged",__threeKillChanged);
         _self.removeEventListener("rightenabledChanged",__rightEnabledChanged);
         _self.removeEventListener("usingItem",__usingItem);
         _self.removeEventListener("shoot",__shoot);
         _self.removeEventListener("attackingChanged",__attackingChanged);
         _self.removeEventListener("setEnable",__setEnable);
         SharedManager.Instance.removeEventListener("transparentChanged",__transparentChanged);
         MaxBtnStateManager.getInstance().removeEvents();
         removeEventListener("maxbtnstate_change",onMaxBtnStateChange);
         MaxBtnStateManager.getInstance().dispose();
         super.removeEvent();
      }
      
      override protected function drawLayer() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _startPos = ComponentFactory.Instance.creatCustomObject("RightPropPos" + _mode);
         var _loc1_:int = _cells.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            if(_mode == 2)
            {
               _loc3_ = _startPos.x + 5;
               _loc2_ = _startPos.y + 6 + _loc4_ * 39;
            }
            else
            {
               _loc3_ = _startPos.x + 6 + _loc4_ * 39;
               _loc2_ = _startPos.y + 5;
            }
            _cells[_loc4_].setPossiton(_loc3_,_loc2_);
            _cells[_loc4_].setMode(_mode);
            if(_inited)
            {
               TweenLite.to(_cells[_loc4_],0.05 * (_loc1_ - _loc4_),{
                  "x":_loc3_,
                  "y":_loc2_
               });
            }
            else
            {
               _cells[_loc4_].x = _loc3_;
               _cells[_loc4_].y = _loc2_;
            }
            _loc4_++;
         }
         DisplayUtils.setFrame(_background,_mode);
         PositionUtils.setPos(_background,_startPos);
      }
      
      override public function enter() : void
      {
         super.enter();
      }
      
      public function get mode() : int
      {
         return _mode;
      }
      
      public function setPropVisible(param1:int, param2:Boolean) : void
      {
         if(param1 < _cells.length)
         {
            _cells[param1].setVisible(param2);
            if(param2)
            {
               if(!_cells[param1].parent)
               {
                  _cellSprite.addChild(_cells[param1]);
               }
            }
            else if(_cells[param1].parent)
            {
               _cells[param1].parent.removeChild(_cells[param1]);
            }
         }
         var _loc5_:int = 0;
         var _loc4_:* = _cells;
         for each(var _loc3_ in _cells)
         {
            if(_loc3_.localVisible)
            {
               setVisible(true);
               return;
            }
         }
         setVisible(false);
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(_localVisible != param1)
         {
            _localVisible = param1;
            if(_localVisible)
            {
               if(_self.isAttacking && parent == null)
               {
                  addChildToContainer();
               }
            }
            else if(parent)
            {
               parent.removeChild(this);
            }
         }
      }
      
      private function addChildToContainer() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         if(_container)
         {
            _loc1_ = int(_container.numChildren);
            _loc2_ = 0;
            while(_loc2_ < _container.numChildren)
            {
               if(_container.getChildAt(_loc2_) is LiveState)
               {
                  _loc1_ = _loc2_;
                  break;
               }
               _loc2_++;
            }
            _container.addChildAt(this,_loc1_);
         }
      }
      
      public function hidePropBar() : void
      {
         this.visible = false;
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
      }
      
      public function showPropBar() : void
      {
         this.visible = true;
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
      }
      
      protected function onDropDownClick(param1:MouseEvent) : void
      {
         dropDownEffect();
         MaxBtnStateManager.getInstance().dropDown();
      }
      
      private function dropDownEffect() : void
      {
         var _loc1_:int = 0;
         dropDown();
         _loc1_ = 3;
         while(_loc1_ < _cells.length)
         {
            _cells[_loc1_].visible = true;
            _cells[_loc1_].mouseEnabled = true;
            _loc1_++;
         }
         _maxBtn.parent && _maxBtn.parent.removeChild(_maxBtn);
         _maxBtn.removeEventListener("click",onMaxClick);
         DisplayUtils.setFrame(_background,2);
         StageReferance.stage.focus = null;
      }
      
      private function dropDown() : void
      {
         isPackUp = false;
         if(_dropDownBtn != null)
         {
            _dropDownBtn.parent && removeChild(_dropDownBtn);
            _dropDownBtn.mouseEnabled = false;
         }
         if(_packUpBtn != null)
         {
            addChild(_packUpBtn);
            _packUpBtn.mouseEnabled = true;
         }
      }
      
      protected function onPackUpClick(param1:MouseEvent) : void
      {
         packUpEffect();
         MaxBtnStateManager.getInstance().packUp();
      }
      
      private function packUpEffect() : void
      {
         var _loc1_:int = 0;
         packUp();
         _loc1_ = 3;
         while(_loc1_ < _cells.length)
         {
            _cells[_loc1_].visible = false;
            _cells[_loc1_].mouseEnabled = false;
            _loc1_++;
         }
         _cellSprite.addChild(_maxBtn);
         _maxBtn.addEventListener("click",onMaxClick);
         DisplayUtils.setFrame(_background,3);
         StageReferance.stage.focus = null;
      }
      
      private function packUp() : void
      {
         isPackUp = true;
         if(_packUpBtn != null)
         {
            _packUpBtn.parent && removeChild(_packUpBtn);
            _packUpBtn.mouseEnabled = false;
         }
         if(_dropDownBtn != null)
         {
            addChild(_dropDownBtn);
            _dropDownBtn.mouseEnabled = true;
         }
      }
      
      protected function onMaxClick(param1:MouseEvent) : void
      {
         if(_enabled)
         {
            useMaxBtn();
         }
      }
      
      private function useMaxBtn() : void
      {
         var _loc1_:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
         _loc1_.addEventListener("energyChanged",onChange);
         sortPercentProps();
         check();
         updatePropByEnergy();
      }
      
      private function onChange(param1:LivingEvent) : void
      {
         check();
      }
      
      private function check() : void
      {
         var _loc2_:int = 0;
         var _loc1_:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
         _loc2_ = 0;
         while(_loc2_ < _percentPropsList.length)
         {
            if(_percentPropsList[_loc2_].info.needEnergy <= _loc1_.energy)
            {
               _percentPropsList[_loc2_].dispatchEvent(new MouseEvent("click"));
               return;
            }
            _loc2_++;
         }
         _loc1_.removeEventListener("energyChanged",onChange);
      }
      
      private function sortPercentProps() : void
      {
         sortPercent = function(param1:PropCell, param2:PropCell):Number
         {
            var _loc3_:int = param1.info.TemplateID;
            var _loc4_:int = param2.info.TemplateID;
            if(_loc3_ < _loc4_)
            {
               return -1;
            }
            if(_loc3_ == _loc4_)
            {
               return 0;
            }
            return 1;
         };
         _percentPropsList.length = 0;
         var j:int = 0;
         while(j < _cells.length)
         {
            switch(int(_cells[j].info.TemplateID) - 10004)
            {
               case 0:
               case 1:
               case 2:
               case 3:
               case 4:
                  _percentPropsList.push(_cells[j]);
            }
            j = Number(j) + 1;
         }
         _percentPropsList.sort(sortPercent);
      }
   }
}
