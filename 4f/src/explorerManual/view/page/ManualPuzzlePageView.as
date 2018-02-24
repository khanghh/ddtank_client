package explorerManual.view.page
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import explorerManual.data.model.ManualDebrisInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ManualPuzzlePageView extends Sprite implements Disposeable
   {
       
      
      private var _debrisInfo:Array;
      
      private var _count:int;
      
      private var _totalWidth:int = 328;
      
      private var _totalHeight:int = 384;
      
      private var _rows:int;
      
      private var _cols:int;
      
      private var _itemW:int;
      
      private var _itemH:int;
      
      private var _allDebris:Array;
      
      private var _allDebrisState:Array;
      
      private var _isCanClick:Boolean = false;
      
      private var _isPuzzleSucceed:Boolean = false;
      
      public function ManualPuzzlePageView(){super();}
      
      public function get isPuzzleSucceed() : Boolean{return false;}
      
      public function set isPuzzleSucceed(param1:Boolean) : void{}
      
      public function set isCanClick(param1:Boolean) : void{}
      
      public function get isCanClick() : Boolean{return false;}
      
      public function set debrisInfo(param1:Array) : void{}
      
      public function set totalDebrisCount(param1:int) : void{}
      
      public function correctionPuzzle() : void{}
      
      private function initPuzzleItem() : void{}
      
      private function __itemClickHandler(param1:MouseEvent) : void{}
      
      private function checkPuzzleResult() : void{}
      
      public function akey() : void{}
      
      public function clear() : void{}
      
      public function dispose() : void{}
   }
}
