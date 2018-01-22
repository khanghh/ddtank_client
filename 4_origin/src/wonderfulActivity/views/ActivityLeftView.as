package wonderfulActivity.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.event.WonderfulActivityEvent;
   
   public class ActivityLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _unitList:Vector.<ActivityLeftUnitView>;
      
      private var tempArray:Array;
      
      private var _rightFun:Function;
      
      private var selectedUnitIndex:int;
      
      private var _isNewServerExist:Boolean = false;
      
      public function ActivityLeftView()
      {
         super();
         initView();
         selectedUnitIndex = -1;
      }
      
      public function setRightView(param1:Function) : void
      {
         _rightFun = param1;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("wonderful.leftview.BG");
         addChild(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.vbox");
         _unitList = new Vector.<ActivityLeftUnitView>();
         addChild(_vbox);
      }
      
      public function addUnitByType(param1:Array, param2:int) : void
      {
         var _loc3_:ActivityLeftUnitView = getLeftUnitView(param2);
         if(_loc3_ == null)
         {
            _loc3_ = new ActivityLeftUnitView(param2);
            _loc3_.addEventListener("selected_change",refreshView);
            _vbox.addChild(_loc3_);
            _unitList.push(_loc3_);
         }
         setBgHeight(_loc3_);
         _loc3_.setData(param1,_rightFun);
         _vbox.refreshChildPos();
      }
      
      private function setBgHeight(param1:ActivityLeftUnitView) : void
      {
         if(isNewServerExist)
         {
            param1.bg.height = 300;
            param1.list.height = 280;
         }
         else
         {
            param1.bg.height = 360;
            param1.list.height = 340;
         }
      }
      
      public function checkNewServerExist() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActivityLeftUnitView = getLeftUnitView(3);
         if(!_loc1_)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _vbox.numChildren)
         {
            if(_vbox.getChildAt(_loc2_) == _loc1_)
            {
               _vbox.removeChildAt(_loc2_);
               _unitList[_loc2_].removeEventListener("selected_change",refreshView);
               _unitList.splice(_unitList.indexOf(_unitList[_loc2_]),1);
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
               break;
            }
            _loc2_++;
         }
         _vbox.refreshChildPos();
      }
      
      public function extendUnitView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = 0;
         if(selectedUnitIndex < 0)
         {
            if(WonderfulActivityManager.Instance.isSkipFromHall)
            {
               _loc3_ = 0;
               while(_loc3_ <= _unitList.length - 1)
               {
                  if(_unitList[_loc3_].type == WonderfulActivityManager.Instance.leftUnitViewType && _unitList[_loc3_].getModelSize() > 0)
                  {
                     _loc1_ = _loc3_;
                     break;
                  }
                  _loc1_ = 2;
                  _loc3_++;
               }
            }
            else
            {
               _loc4_ = 0;
               while(_loc4_ <= _unitList.length - 1)
               {
                  if(_unitList[_loc4_].getModelSize() > 0)
                  {
                     _loc1_ = _loc4_;
                     break;
                  }
                  _loc4_++;
               }
            }
         }
         else
         {
            if(selectedUnitIndex > _unitList.length - 1)
            {
               selectedUnitIndex = 0;
            }
            _loc1_ = int(selectedUnitIndex);
         }
         (_unitList[_loc1_] as ActivityLeftUnitView).extendSelecteTheFirst();
         _loc2_ = 0;
         while(_loc2_ <= _unitList.length - 1)
         {
            if(_loc2_ != _loc1_)
            {
               (_unitList[_loc2_] as ActivityLeftUnitView).unextendHandler();
            }
            _loc2_++;
         }
         _vbox.refreshChildPos();
      }
      
      private function getLeftUnitView(param1:int) : ActivityLeftUnitView
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ <= _unitList.length - 1)
         {
            if(param1 == _unitList[_loc2_].type)
            {
               return _unitList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function refreshView(param1:WonderfulActivityEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ActivityLeftUnitView = param1.target as ActivityLeftUnitView;
         _loc3_ = 0;
         while(_loc3_ <= _unitList.length - 1)
         {
            if(_unitList[_loc3_] == _loc2_)
            {
               selectedUnitIndex = _loc3_;
            }
            else
            {
               _unitList[_loc3_].unextendHandler();
            }
            _loc3_++;
         }
         _vbox.arrange();
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= _unitList.length - 1)
         {
            _unitList[_loc1_].removeEventListener("selected_change",refreshView);
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_unitList)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _unitList;
            for each(var _loc1_ in _unitList)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         _unitList = null;
      }
      
      public function get isNewServerExist() : Boolean
      {
         return _isNewServerExist;
      }
      
      public function set isNewServerExist(param1:Boolean) : void
      {
         _isNewServerExist = param1;
      }
   }
}
