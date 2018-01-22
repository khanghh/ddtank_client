package treasureRoom.view
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mark.MarkMgr;
   import treasureRoom.mornui.TreasureRoomRewardViewUI;
   
   public class TreasureRoomRewardView extends TreasureRoomRewardViewUI
   {
       
      
      private var _type:int;
      
      private var _rewardInfoArr:Array;
      
      private var _cellSprite:Sprite;
      
      public function TreasureRoomRewardView(param1:int, param2:Array)
      {
         _type = param1;
         _rewardInfoArr = param2;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cellSprite = new Sprite();
         while(_loc2_ < _rewardInfoArr.length)
         {
            _loc1_ = new TreasureRoomRewardItem(_rewardInfoArr[_loc2_],MarkMgr.inst.treasureRoomLogoIdArr[_loc2_]);
            _loc1_.x = _loc2_ * (_loc1_.width + 4) + 15;
            if(_loc2_ > 4)
            {
               _loc1_.x = (_loc2_ - 5) * (_loc1_.width + 4) + 15;
               _loc1_.y = _loc1_.height + 3;
            }
            _cellSprite.addChild(_loc1_);
            _loc2_++;
         }
         addChild(_cellSprite);
         if(_type == 0)
         {
            bg.height = 78;
            PositionUtils.setPos(_cellSprite,"asset.treasureRoom.TreasureRoomRewardView.cellSpritePos1");
         }
         else if(_type == 1)
         {
            bg.height = 121;
            PositionUtils.setPos(_cellSprite,"asset.treasureRoom.TreasureRoomRewardView.cellSpritePos2");
         }
      }
      
      private function addEvent() : void
      {
         closeBtn.addEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("CLOSE"));
      }
      
      private function removeEvent() : void
      {
         closeBtn.removeEventListener("click",__onClickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_cellSprite)
         {
            ObjectUtils.disposeObject(_cellSprite);
         }
         _cellSprite = null;
         super.dispose();
      }
   }
}
