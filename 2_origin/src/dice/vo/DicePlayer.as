package dice.vo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import vip.VipController;
   
   public class DicePlayer extends DicePlayerBase
   {
       
      
      private var _playerInfo:SelfInfo;
      
      private var _lblName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _moveSpeedX:Number = 5;
      
      private var _moveSpeedY:Number = 4;
      
      private var _isShowName:Boolean = true;
      
      private var _propertyContainer:Sprite;
      
      private var _light:MovieClip;
      
      private var _isWalking:Boolean;
      
      public function DicePlayer(param1:Function = null)
      {
         _playerInfo = PlayerManager.Instance.Self;
         super(_playerInfo,SynchronousPosition,param1);
         preInitialize();
         initialize();
         addEvent();
      }
      
      public function get isWalking() : Boolean
      {
         return _isWalking;
      }
      
      public function set isWalking(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(_isWalking != param1)
         {
            _isWalking = param1;
            _loc2_ = {};
            _loc2_.isWalking = _isWalking;
            DiceController.Instance.dispatchEvent(new DiceEvent("dice_player_iswalking",_loc2_));
            if(_isWalking)
            {
               _light.visible = false;
            }
            else
            {
               _light.visible = true;
            }
         }
      }
      
      private function preInitialize() : void
      {
         _propertyContainer = new Sprite();
         _lblName = ComponentFactory.Instance.creatComponentByStylename("asset.dice.lblName");
         _light = ComponentFactory.Instance.creat("asset.dice.destinationLight");
         PositionUtils.setPos(_light,"asset.dice.playerlight.pos");
      }
      
      private function addEvent() : void
      {
         addEventListener("characterDirectionChange",characterDirectionChange);
         addEventListener("enterFrame",__update);
      }
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void
      {
         isWalking = Boolean(param1.data);
         if(_isWalking)
         {
            if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
            {
               if(sceneCharacterStateType == "natural")
               {
                  character.scaleX = 1;
                  character.x = 0;
                  sceneCharacterActionType = "naturalWalkBack";
               }
            }
            else if(sceneCharacterDirection == SceneCharacterDirection.RB)
            {
               if(sceneCharacterStateType == "natural")
               {
                  character.scaleX = 1;
                  character.x = 0;
                  sceneCharacterActionType = "naturalWalkFront";
               }
            }
            else if(sceneCharacterDirection.type == "LB")
            {
               if(sceneCharacterStateType == "natural")
               {
                  if(sceneCharacterDirection.isMirror)
                  {
                     sceneCharacterActionType = "naturalWalkFront";
                     character.scaleX = -1;
                     character.x = _playerWidth;
                  }
                  else
                  {
                     character.scaleX = 1;
                     character.x = 0;
                     sceneCharacterActionType = "naturalWalkFront";
                  }
               }
            }
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
         {
            if(sceneCharacterStateType == "natural")
            {
               character.scaleX = 1;
               character.x = 0;
               sceneCharacterActionType = "naturalStandBack";
            }
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.RB)
         {
            if(sceneCharacterStateType == "natural")
            {
               character.scaleX = 1;
               character.x = 0;
               sceneCharacterActionType = "naturalStandFront";
            }
         }
         else if(sceneCharacterDirection.type == "LB")
         {
            if(sceneCharacterStateType == "natural")
            {
               if(sceneCharacterDirection.isMirror)
               {
                  character.scaleX = -1;
                  character.x = _playerWidth;
                  sceneCharacterActionType = "naturalStandFront";
               }
               else
               {
                  character.scaleX = 1;
                  character.x = 0;
                  sceneCharacterActionType = "naturalStandFront";
               }
            }
         }
      }
      
      private function __update(param1:Event) : void
      {
         if(character)
         {
            update();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__update);
         removeEventListener("characterDirectionChange",characterDirectionChange);
      }
      
      private function initialize() : void
      {
         mouseEnabled = false;
         mouseChildren = false;
         addChildAt(_propertyContainer,0);
         addChild(_light);
         _lblName.text = _playerInfo && _playerInfo.NickName?_playerInfo.NickName:"";
         _lblName.textColor = 6029065;
         if(_playerInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(-1,_playerInfo.typeVIP);
            _vipName.x = _lblName.x;
            _vipName.y = _lblName.y;
            _vipName.text = _lblName.text;
            _vipIcon = ComponentFactory.Instance.creatCustomObject("asset.dic.VipIcon");
            _vipIcon.setInfo(_playerInfo);
            _propertyContainer.addChild(_vipName);
            _propertyContainer.addChild(_vipIcon);
            var _loc1_:* = _isShowName;
            _vipIcon.visible = _loc1_;
            _vipName.visible = _loc1_;
            _lblName.dispose();
            _lblName = null;
         }
         else
         {
            _propertyContainer.addChild(_lblName);
            _lblName.visible = _isShowName;
         }
      }
      
      private function SynchronousPosition(param1:Point) : void
      {
      }
      
      public function PlayerWalkByPosition(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         trace(param1,param2,"===============================================================================================");
         var _loc4_:Array = [];
         if(param1 < 0 || param1 >= DiceController.Instance.CELL_COUNT)
         {
            return;
         }
         if(param2 == 0 && !DiceController.Instance.hasUsedFirstCell)
         {
            param2 = 1;
         }
         _loc4_.push(GetCoordinatesByPosition(param1));
         while(param1 != param2)
         {
            param1++;
            param1 = param1 % DiceController.Instance.CELL_COUNT;
            _loc4_.push(GetCoordinatesByPosition(param1));
         }
         playerWalk(_loc4_);
      }
      
      public function GetCoordinatesByPosition(param1:int) : Point
      {
         var _loc2_:* = null;
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 >= DiceController.Instance.CELL_COUNT)
         {
            param1 = DiceController.Instance.CELL_COUNT - 1;
         }
         if(DiceController.Instance.cellPosition == null)
         {
            DiceController.Instance.setCellInfo();
         }
         return (DiceController.Instance.cellPosition[param1] as DiceCellInfo).CellCenterPosition;
      }
      
      public function set CurrentPosition(param1:int) : void
      {
         var _loc2_:Point = GetCoordinatesByPosition(param1);
         x = _loc2_.x;
         y = _loc2_.y;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lblName);
         _lblName = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
