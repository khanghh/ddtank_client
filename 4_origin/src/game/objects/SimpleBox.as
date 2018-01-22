package game.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.objects.GhostBoxModel;
   import gameCommon.view.smallMap.SmallBox;
   import phy.object.PhysicalObj;
   import phy.object.SmallObject;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class SimpleBox extends SimpleObject
   {
       
      
      private var _dieMC:MovieClipWrapper;
      
      private var _box:ScaleFrameImage;
      
      private var _ghostBox:MovieClip;
      
      private var _smallBox:SmallObject;
      
      private var _isGhostBox:Boolean;
      
      private var _subType:int = 0;
      
      private var _localVisible:Boolean = true;
      
      private var _constainer:DisplayObjectContainer;
      
      private var _self:LocalPlayer;
      
      private var _visible:Boolean = true;
      
      public function SimpleBox(param1:int, param2:String, param3:int = 1)
      {
         _subType = param3;
         _self = GameControl.Instance.Current.selfGamePlayer;
         super(param1,1,param2,"");
         this.x = x;
         this.y = y;
         _canCollided = true;
         if(isGhost)
         {
            setCollideRect(-8,-8,16,16);
         }
         else
         {
            setCollideRect(-15,-15,30,30);
         }
         _smallBox = new SmallBox();
         _isGhostBox = false;
         if(isGhost)
         {
            visible = !_self.isLiving;
            _canCollided = !_self.isLiving;
            smallView.visible = false;
         }
         else
         {
            visible = _self.isLiving;
            _canCollided = _self.isLiving;
            smallView.visible = _self.isLiving;
         }
         addEvent();
      }
      
      override public function get smallView() : SmallObject
      {
         return _smallBox;
      }
      
      override public function get layer() : int
      {
         if(_isGhostBox)
         {
            return 3;
         }
         return super.layer;
      }
      
      private function addEvent() : void
      {
         _self.addEventListener("die",__onSelfPlayerDie);
         _self.addEventListener("livingRevive",__onSelfPlayerRevive);
      }
      
      private function __click(param1:MouseEvent) : void
      {
         if(parent)
         {
            parent.setChildIndex(this,parent.numChildren - 1);
         }
      }
      
      private function removeEvent() : void
      {
         _self.removeEventListener("die",__onSelfPlayerDie);
         _self.removeEventListener("livingRevive",__onSelfPlayerRevive);
         removeEventListener("click",__click);
         if(_dieMC)
         {
            _dieMC.removeEventListener("complete",__boxDieComplete);
         }
      }
      
      public function get isGhost() : Boolean
      {
         return _subType > 1;
      }
      
      public function get subType() : int
      {
         return _subType;
      }
      
      public function get psychic() : int
      {
         return GhostBoxModel.getInstance().getPsychicByType(_subType);
      }
      
      protected function setIsGhost(param1:Boolean) : void
      {
         if(param1 == _isGhostBox)
         {
            return;
         }
         _isGhostBox = param1;
         if(!_isGhostBox == GameControl.Instance.Current.selfGamePlayer.isLiving)
         {
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function pickByLiving(param1:Living) : void
      {
         param1.pick(this);
         if(!_self.isLiving)
         {
            SoundManager.instance.play("018");
         }
         die();
      }
      
      override protected function creatMovie(param1:String) : void
      {
         if(isGhost)
         {
            _ghostBox = ClassUtils.CreatInstance("asset.game.GhostBox" + (_subType - 1)) as MovieClip;
            var _loc2_:* = false;
            _ghostBox.mouseEnabled = _loc2_;
            _ghostBox.mouseChildren = _loc2_;
            _ghostBox.visible = isGhost;
            _loc2_ = 4;
            _ghostBox.y = _loc2_;
            _ghostBox.x = _loc2_;
            _ghostBox.gotoAndPlay("stand");
            addChild(_ghostBox);
         }
         else
         {
            _box = ComponentFactory.Instance.creatComponentByStylename("asset.game.simpleBoxPicAsset");
            _box.x = -_box.width >> 1;
            _box.y = -_box.height >> 1;
            _box.setFrame(int(param1));
            addChild(_box);
         }
      }
      
      public function setContainer(param1:DisplayObjectContainer) : void
      {
         _constainer = param1;
         if(super.visible)
         {
            if(isGhost)
            {
               if(!_self.isLiving && !parent)
               {
                  _constainer.addChild(this);
               }
            }
            else
            {
               _constainer.addChild(this);
            }
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(!_self.isLiving)
         {
            if(isGhost && RoomManager.Instance.current && GameControl.Instance.Current.togetherShoot)
            {
               .super.visible = false;
            }
            else
            {
               .super.visible = param1 && isGhost;
            }
         }
         else
         {
            .super.visible = param1 && !isGhost;
         }
      }
      
      override public function collidedByObject(param1:PhysicalObj) : void
      {
         if(param1 is SimpleBomb)
         {
            SimpleBomb(param1).owner.pick(this);
            if(!isGhost && _self.isLiving)
            {
               SoundManager.instance.play("018");
            }
            die();
         }
      }
      
      override public function die() : void
      {
         var _loc1_:* = null;
         if(!_isLiving)
         {
            return;
         }
         _canCollided = false;
         if(visible)
         {
            if(isGhost)
            {
               _loc1_ = ClassUtils.CreatInstance("asset.game.GhostBoxDie") as MovieClip;
               if(_ghostBox && _ghostBox.parent)
               {
                  _ghostBox.stop();
                  _ghostBox.parent.removeChild(_ghostBox);
               }
            }
            else
            {
               _loc1_ = ClassUtils.CreatInstance("asset.game.pickBoxAsset") as MovieClip;
               if(_box && _box.parent)
               {
                  _box.parent.removeChild(_box);
               }
            }
            _dieMC = new MovieClipWrapper(_loc1_,true,true);
            _dieMC.addEventListener("complete",__boxDieComplete);
            addChild(_dieMC.movie);
            smallView.visible = false;
         }
         super.die();
      }
      
      protected function __boxDieComplete(param1:Event) : void
      {
         if(_dieMC)
         {
            _dieMC.removeEventListener("complete",__boxDieComplete);
            dispose();
         }
      }
      
      override public function isBox() : Boolean
      {
         return true;
      }
      
      override public function get canCollided() : Boolean
      {
         if(isGhost)
         {
            return !_self.isLiving;
         }
         return _canCollided;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_dieMC);
         _dieMC = null;
         ObjectUtils.disposeObject(_smallBox);
         _smallBox = null;
         ObjectUtils.disposeObject(_ghostBox);
         _ghostBox = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         _self = null;
         super.dispose();
      }
      
      override public function playAction(param1:String) : void
      {
         var _loc2_:* = param1;
         if("BoxNormal" !== _loc2_)
         {
            if("BoxColorChanged" !== _loc2_)
            {
               if("BoxColorRestored" === _loc2_)
               {
                  if(_box)
                  {
                     _box.visible = false;
                  }
                  setIsGhost(true);
               }
            }
            else
            {
               if(_box)
               {
                  _box.visible = false;
               }
               setIsGhost(true);
            }
         }
         else
         {
            _box.visible = true;
            setIsGhost(false);
         }
      }
      
      private function __onSelfPlayerDie(param1:Event) : void
      {
         if(!_self.isLast)
         {
            visible = isGhost;
         }
      }
      
      private function __onSelfPlayerRevive(param1:Event) : void
      {
         if(isGhost)
         {
            visible = false;
         }
      }
   }
}
