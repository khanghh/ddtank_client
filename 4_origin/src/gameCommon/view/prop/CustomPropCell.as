package gameCommon.view.prop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.FightPropEevnt;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import room.RoomManager;
   
   public class CustomPropCell extends PropCell
   {
       
      
      private var _deleteBtn:SimpleBitmapButton;
      
      private var _type:int;
      
      private var _lockIcon:Bitmap;
      
      private var _isLock:Boolean = false;
      
      private var _countTxt:FilterFrameText;
      
      public function CustomPropCell(param1:String, param2:int, param3:int)
      {
         super(param1,param2);
         _type = param3;
         mouseChildren = false;
         if(_type)
         {
            _tipInfo.valueType = null;
         }
      }
      
      public function set isLock(param1:Boolean) : void
      {
         if(param1)
         {
            _lockIcon.visible = true;
            info = null;
         }
         else
         {
            _lockIcon.visible = false;
         }
         _isLock = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.deletePropBtn");
         _lockIcon = ComponentFactory.Instance.creatBitmap("asset.game.onlyLockIcon");
         _lockIcon.visible = false;
         addChild(_lockIcon);
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("game.customPropCell.countTxt");
         _countTxt.visible = false;
         addChild(_countTxt);
      }
      
      override protected function drawLayer() : void
      {
      }
      
      override protected function __mouseOut(param1:MouseEvent) : void
      {
         if(_deleteBtn.parent)
         {
            removeChild(_deleteBtn);
         }
         x = _x;
         y = _y;
         scaleY = 1;
         scaleX = 1;
         var _loc2_:int = 1;
         _shortcutKeyShape.scaleY = _loc2_;
         _shortcutKeyShape.scaleX = _loc2_;
         if(_tweenMax)
         {
            _tweenMax.pause();
         }
         filters = null;
      }
      
      override protected function __mouseOver(param1:MouseEvent) : void
      {
         if(!(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI))
         {
            if(_info && !(RoomManager.Instance.current && RoomManager.Instance.current.type == 21) && _info.TemplateID != 10471)
            {
               addChild(_deleteBtn);
            }
         }
         super.__mouseOver(param1);
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         addEventListener("click",__clicked);
      }
      
      private function __deleteClick(param1:MouseEvent) : void
      {
      }
      
      private function deleteContainMouse() : Boolean
      {
         var _loc1_:Rectangle = _deleteBtn.getBounds(this);
         return _loc1_.contains(mouseX,mouseY);
      }
      
      private function deleteProp() : void
      {
         dispatchEvent(new FightPropEevnt("delete"));
      }
      
      private function __clicked(param1:MouseEvent) : void
      {
         StageReferance.stage.focus = null;
         if(_deleteBtn.parent && deleteContainMouse())
         {
            deleteProp();
         }
         else
         {
            useProp();
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(_enabled != param1)
         {
            _enabled = param1;
            if(!_enabled)
            {
               if(_asset)
               {
                  _asset.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               }
               __mouseOut(null);
            }
            else if(_asset)
            {
               _asset.filters = null;
            }
         }
      }
      
      override public function useProp() : void
      {
         var _loc1_:* = null;
         if(_info != null && !isUsed)
         {
            if(_info.Template.CategoryID == 10 && _info.Template.Property1 == "54")
            {
               if(!GameControl.Instance.Current.selfGamePlayer.isAttacking)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.NotAttacking"));
                  return;
               }
               if(!GameControl.Instance.Current.isHasOneDead)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.game.reviveItem.cannotUseTxt"));
                  return;
               }
            }
            _loc1_ = GameControl.Instance.Current.selfGamePlayer;
            if(_info && _info.TemplateID == 10611 && !_loc1_.usePassBall)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop.usePassBall"));
               return;
            }
            isUsed = true;
            setTimeout(resetIsUse,1000);
            dispatchEvent(new FightPropEevnt("use"));
         }
      }
      
      private function resetIsUse() : void
      {
         isUsed = false;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("click",__clicked);
      }
      
      override public function set info(param1:PropInfo) : void
      {
         var _loc2_:* = null;
         if(_isLock)
         {
            return;
         }
         ShowTipManager.Instance.removeTip(this);
         _info = param1;
         var _loc3_:DisplayObject = _asset;
         if(_info != null)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop" + _info.Template.Pic + "Asset");
            if(_loc2_)
            {
               _loc2_.smoothing = true;
               var _loc4_:int = 1;
               _loc2_.y = _loc4_;
               _loc2_.x = _loc4_;
               _loc4_ = 35;
               _loc2_.height = _loc4_;
               _loc2_.width = _loc4_;
               addChildAt(_loc2_,getChildIndex(_fore));
            }
            if(_asset)
            {
               _loc2_.filters = _asset.filters;
            }
            _asset = _loc2_;
            _tipInfo.info = _info.Template;
            _tipInfo.shortcutKey = _shortcutKey;
            ShowTipManager.Instance.addTip(this);
            buttonMode = true;
            if(RoomManager.Instance.current.type == 21)
            {
               _countTxt.text = (_info.Template as InventoryItemInfo).Count.toString();
               _countTxt.visible = true;
            }
         }
         else
         {
            buttonMode = false;
            _countTxt.visible = false;
         }
         if(_loc3_ != null)
         {
            ObjectUtils.disposeObject(_loc3_);
         }
         isUsed = false;
         if(_info == null)
         {
            __mouseOut(null);
         }
      }
      
      public function setCount(param1:int) : void
      {
         _countTxt.text = param1.toString();
         _countTxt.visible = true;
      }
      
      override public function setPossiton(param1:int, param2:int) : void
      {
         super.setPossiton(param1,param2);
         this.x = _x;
         this.y = _y;
      }
      
      override public function dispose() : void
      {
         if(_deleteBtn)
         {
            ObjectUtils.disposeObject(_deleteBtn);
            _deleteBtn = null;
         }
         ObjectUtils.disposeObject(_lockIcon);
         _lockIcon = null;
         super.dispose();
      }
      
      override public function get tipDirctions() : String
      {
         if(_type != 0)
         {
            return "4,5,7,1,6,2";
         }
         return super.tipDirctions;
      }
   }
}
