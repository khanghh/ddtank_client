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
      
      public function DicePlayer(callBack:Function = null)
      {
         _playerInfo = PlayerManager.Instance.Self;
         super(_playerInfo,SynchronousPosition,callBack);
         preInitialize();
         initialize();
         addEvent();
      }
      
      public function get isWalking() : Boolean
      {
         return _isWalking;
      }
      
      public function set isWalking(value:Boolean) : void
      {
         var proxy:* = null;
         if(_isWalking != value)
         {
            _isWalking = value;
            proxy = {};
            proxy.isWalking = _isWalking;
            DiceController.Instance.dispatchEvent(new DiceEvent("dice_player_iswalking",proxy));
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
      
      private function characterDirectionChange(evt:SceneCharacterEvent) : void
      {
         isWalking = Boolean(evt.data);
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
      
      private function __update(event:Event) : void
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
      
      private function SynchronousPosition(value:Point) : void
      {
      }
      
      public function PlayerWalkByPosition(start:int, end:int) : void
      {
         var pt:* = null;
         trace(start,end,"===============================================================================================");
         var path:Array = [];
         if(start < 0 || start >= DiceController.Instance.CELL_COUNT)
         {
            return;
         }
         if(end == 0 && !DiceController.Instance.hasUsedFirstCell)
         {
            end = 1;
         }
         path.push(GetCoordinatesByPosition(start));
         while(start != end)
         {
            start++;
            start = start % DiceController.Instance.CELL_COUNT;
            path.push(GetCoordinatesByPosition(start));
         }
         playerWalk(path);
      }
      
      public function GetCoordinatesByPosition(value:int) : Point
      {
         var cell:* = null;
         if(value < 0)
         {
            value = 0;
         }
         else if(value >= DiceController.Instance.CELL_COUNT)
         {
            value = DiceController.Instance.CELL_COUNT - 1;
         }
         if(DiceController.Instance.cellPosition == null)
         {
            DiceController.Instance.setCellInfo();
         }
         return (DiceController.Instance.cellPosition[value] as DiceCellInfo).CellCenterPosition;
      }
      
      public function set CurrentPosition(value:int) : void
      {
         var pt:Point = GetCoordinatesByPosition(value);
         x = pt.x;
         y = pt.y;
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
