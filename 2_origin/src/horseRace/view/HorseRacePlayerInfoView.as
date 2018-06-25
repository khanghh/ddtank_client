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
      
      public function addPlayerItem(playerItem:HorseRacePlayerItemView) : void
      {
         _vbox.addChild(playerItem);
         playerItem.addEventListener("click",_itemClick);
         _itemList.push(playerItem);
      }
      
      public function flushBuffList() : void
      {
         var item2:* = null;
         var i:int = 0;
         var buffList:* = null;
         for(i = 0; i < _itemList.length; )
         {
            item2 = _itemList[i] as HorseRacePlayerItemView;
            buffList = item2.getPlayerInfo().buffList;
            item2.flashBuffList(buffList);
            i++;
         }
      }
      
      private function _itemClick(e:MouseEvent) : void
      {
         var item2:* = null;
         var i:int = 0;
         var item:HorseRacePlayerItemView = e.currentTarget as HorseRacePlayerItemView;
         for(i = 0; i < _itemList.length; )
         {
            item2 = _itemList[i] as HorseRacePlayerItemView;
            if(item2.getPlayerInfo().playerVO.playerInfo.ID == item.getPlayerInfo().playerVO.playerInfo.ID)
            {
               item2.setBgVisible(true);
               selectItemId = item.getPlayerInfo().playerVO.playerInfo.ID;
            }
            else
            {
               item2.setBgVisible(false);
            }
            i++;
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
