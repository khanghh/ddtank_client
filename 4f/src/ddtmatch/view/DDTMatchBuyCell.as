package ddtmatch.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class DDTMatchBuyCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _zhuTxt:FilterFrameText;
      
      private var _bettingWinTxt:FilterFrameText;
      
      private var _bettingLoseTxt:FilterFrameText;
      
      private var _hostBuy:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var choose:int = 0;
      
      private var _index:int;
      
      private var _type:int;
      
      private var roundNumberMc:MovieClip;
      
      private var winCell:BagCell;
      
      private var loseCell:BagCell;
      
      private var _combox:ComboBox;
      
      private var countryNameList:Array;
      
      private var list:Array;
      
      private var maxBuy:int;
      
      private var _num:int;
      
      public function DDTMatchBuyCell(param1:int, param2:int){super();}
      
      private function addEvent() : void{}
      
      public function setinfo(param1:int, param2:int) : void{}
      
      private function changeHandler(param1:Event) : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function remove() : void{}
      
      public function dispose() : void{}
   }
}
