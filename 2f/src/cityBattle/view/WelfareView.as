package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.data.WelfareInfo;
   import cityBattle.event.CityBattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WelfareView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _myScoreTxt:FilterFrameText;
      
      private var _box:Sprite;
      
      private var _winBtn:MovieClip;
      
      private var _prize:WinnerPrizeView;
      
      public function WelfareView(){super();}
      
      private function init() : void{}
      
      private function _scoreChange(param1:CityBattleEvent) : void{}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
