package wonderfulActivity.views
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.list.IListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.IShineableCell;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.ActivityCellVo;
   import wonderfulActivity.event.WonderfulActivityEvent;
   
   public class ActivityLeftUnitView extends Sprite implements Disposeable
   {
      
      public static const TYPE_WONDER:int = 2;
      
      public static const TYPE_LIMINT:int = 1;
      
      public static const TYPE_NEWSERVER:int = 3;
      
      public static const TYPE_EXCHANGE_ACT:int = 4;
       
      
      private var _selectedBtn:SelectedButton;
      
      private var _bg:ScaleBitmapImage;
      
      private var _list:ListPanel;
      
      private var _type:int;
      
      private var dataList:Array;
      
      private var _selectedValue:ActivityCellVo;
      
      private var _updateFun:Function;
      
      private var _currentID:String;
      
      private var hasClickSound:Boolean = true;
      
      public function ActivityLeftUnitView(param1:int){super();}
      
      public function get type() : int{return 0;}
      
      public function setData(param1:Array, param2:Function) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function initData() : void{}
      
      private function getSelectedBtn() : SelectedButton{return null;}
      
      private function __selectedBtnClick(param1:MouseEvent) : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      public function extendSelecteTheFirst() : void{}
      
      private function autoSelect() : void{}
      
      private function getIndexInModel(param1:String) : int{return 0;}
      
      private function extendHandler() : void{}
      
      public function unextendHandler() : void{}
      
      public function getModelSize() : int{return 0;}
      
      override public function get height() : Number{return 0;}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get bg() : ScaleBitmapImage{return null;}
      
      public function set bg(param1:ScaleBitmapImage) : void{}
      
      public function get list() : ListPanel{return null;}
      
      public function set list(param1:ListPanel) : void{}
   }
}
