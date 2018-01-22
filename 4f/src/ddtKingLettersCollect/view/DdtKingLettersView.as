package ddtKingLettersCollect.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddtKingLettersCollect.DdtKingLettersCollectController;
   import ddtKingLettersCollect.DdtKingLettersCollectManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import org.aswing.KeyboardManager;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   
   public class DdtKingLettersView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _detailTxt:FilterFrameText;
      
      private var _letterCellList:Vector.<BagCell>;
      
      private var _letterCellComposed:BagCell;
      
      private var _composeBtn:SimpleBitmapButton;
      
      public function DdtKingLettersView(){super();}
      
      private function init() : void{}
      
      protected function __onExchangeGoods(param1:PkgEvent) : void{}
      
      protected function onComposeClick(param1:MouseEvent) : void{}
      
      private function canCompose(param1:*, param2:int, param3:Vector.<BagCell>) : Boolean{return false;}
      
      public function update(param1:CEvent = null) : void{}
      
      private function addZero(param1:Number) : String{return null;}
      
      protected function onKeyDown(param1:KeyboardEvent) : void{}
      
      protected function onCloseBtnClick(param1:MouseEvent) : void{}
      
      private function close() : void{}
      
      public function dispose() : void{}
   }
}
