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
      
      public function TreasureRoomRewardView(type:int, rewardInfoArr:Array)
      {
         _type = type;
         _rewardInfoArr = rewardInfoArr;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _cellSprite = new Sprite();
         while(i < _rewardInfoArr.length)
         {
            item = new TreasureRoomRewardItem(_rewardInfoArr[i],MarkMgr.inst.treasureRoomLogoIdArr[i]);
            item.x = i * (item.width + 4) + 15;
            if(i > 4)
            {
               item.x = (i - 5) * (item.width + 4) + 15;
               item.y = item.height + 3;
            }
            _cellSprite.addChild(item);
            i++;
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
      
      private function __onClickHandler(event:MouseEvent) : void
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
