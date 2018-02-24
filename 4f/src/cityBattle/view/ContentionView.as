package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.event.CityBattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ContentionView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _infoTxt:FilterFrameText;
      
      private var _currentSocreTxt:FilterFrameText;
      
      private var _currentRankTxt:FilterFrameText;
      
      private var blueTable:ContentionTable;
      
      private var redTable:ContentionTable;
      
      private var _inspireBtn:BaseButton;
      
      private var _blueTotalScore:FilterFrameText;
      
      private var _redTotalScore:FilterFrameText;
      
      public function ContentionView(){super();}
      
      private function initView() : void{}
      
      private function _scoreChange(param1:CityBattleEvent) : void{}
      
      private function _inspireBtnHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
