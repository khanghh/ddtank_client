package dayActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActivityManager;
   import dayActivity.DayRewaidData;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class DayActivityRightViewItem extends Sprite implements Disposeable
   {
       
      
      public var id:int;
      
      private var _back:ScaleBitmapImage;
      
      private var _txt1:FilterFrameText;
      
      private var _list:Vector.<BagCell>;
      
      private var _btn1:SimpleBitmapButton;
      
      private var _btn2:SimpleBitmapButton;
      
      private var _lightBitMap:MovieClip;
      
      public function DayActivityRightViewItem(param1:int){super();}
      
      private function initView(param1:int) : void{}
      
      private function clickHander(param1:MouseEvent) : void{}
      
      public function showBtn(param1:Boolean) : void{}
      
      private function applyGray(param1:DisplayObject) : void{}
      
      private function applyFilter(param1:DisplayObject, param2:Array) : void{}
      
      private function initGoods(param1:Vector.<DayRewaidData>, param2:int) : void{}
      
      public function dispose() : void{}
   }
}
