package beadSystem.views
{
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class BeadAdvancedView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _leftView:BeadAdvancedListView;
      
      private var _rightView:BeadAdvancedRightView;
      
      private var _curPageIndex:int = -1;
      
      public function BeadAdvancedView()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bag.beadSystem.bg");
         addChild(_bg);
         _leftView = new BeadAdvancedListView();
         PositionUtils.setPos(_leftView,"beadSystem.beadAdvance.beadAdvanceListView.Pos");
         _rightView = new BeadAdvancedRightView();
         PositionUtils.setPos(_rightView,"beadSystem.beadAdvance.beadAdvanceRightView.Pos");
         addChild(_leftView);
         addChild(_rightView);
      }
      
      protected function initEvent() : void
      {
         if(_leftView)
         {
            _leftView.addEventListener("beadSelectChange",selectChangeHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_leftView)
         {
            _leftView.removeEventListener("beadSelectChange",selectChangeHandler);
         }
      }
      
      public function update(param1:DictionaryData) : void
      {
         if(_leftView)
         {
            _leftView.beadInfos = param1;
         }
      }
      
      public function refresh() : void
      {
         _rightView.refresh();
      }
      
      public function set curPageIndex(param1:int) : void
      {
         _curPageIndex = param1;
      }
      
      public function get curPageIndex() : int
      {
         return _curPageIndex;
      }
      
      public function selectChangeHandler(param1:CEvent) : void
      {
         var _loc2_:AdvanceBeadInfo = param1.data as AdvanceBeadInfo;
         _rightView.update(_loc2_,curPageIndex);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_leftView)
         {
            ObjectUtils.disposeObject(_leftView);
         }
         _leftView = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
      }
   }
}
