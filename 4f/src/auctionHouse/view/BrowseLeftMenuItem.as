package auctionHouse.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.CateCoryInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BrowseLeftMenuItem extends Sprite implements Disposeable, IMenuItem
   {
       
      
      private var accect:BrowserLeftStripAsset;
      
      private var _info:CateCoryInfo;
      
      private var _isOpen:Boolean = false;
      
      private var _hasIcon:Boolean;
      
      private var _hideIcon:Boolean;
      
      public function BrowseLeftMenuItem(param1:BrowserLeftStripAsset, param2:CateCoryInfo, param3:Boolean = false){super();}
      
      private function initEvent() : void{}
      
      public function dispose() : void{}
      
      private function removeRollEvent() : void{}
      
      private function addRollEvent() : void{}
      
      private function initView() : void{}
      
      public function get info() : Object{return null;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function set isOpen(param1:Boolean) : void{}
      
      public function set enable(param1:Boolean) : void{}
      
      private function btnClickHandler(param1:MouseEvent) : void{}
   }
}
