package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HorseRacePlayerInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _itemList:Array;
      
      public var selectItemId:int = 0;
      
      public function HorseRacePlayerInfoView()
      {
         _itemList = [];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("horseRace.raceView.playerInfoBg");
         addChild(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.raceView.PlayerList");
         addChild(_vbox);
      }
      
      public function addPlayerItem(param1:HorseRacePlayerItemView) : void
      {
         _vbox.addChild(param1);
         param1.addEventListener("click",_itemClick);
         _itemList.push(param1);
      }
      
      public function flushBuffList() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc3_] as HorseRacePlayerItemView;
            _loc2_ = _loc1_.getPlayerInfo().buffList;
            _loc1_.flashBuffList(_loc2_);
            _loc3_++;
         }
      }
      
      private function _itemClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:HorseRacePlayerItemView = param1.currentTarget as HorseRacePlayerItemView;
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc4_] as HorseRacePlayerItemView;
            if(_loc2_.getPlayerInfo().playerVO.playerInfo.ID == _loc3_.getPlayerInfo().playerVO.playerInfo.ID)
            {
               _loc2_.setBgVisible(true);
               selectItemId = _loc3_.getPlayerInfo().playerVO.playerInfo.ID;
            }
            else
            {
               _loc2_.setBgVisible(false);
            }
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
