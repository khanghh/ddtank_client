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
      
      public function setRightView(fun:Function) : void
      {
         _rightFun = fun;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("wonderful.leftview.BG");
         addChild(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.vbox");
         _unitList = new Vector.<ActivityLeftUnitView>();
         addChild(_vbox);
      }
      
      public function addUnitByType(arr:Array, type:int) : void
      {
         var leftUnit:ActivityLeftUnitView = getLeftUnitView(type);
         if(leftUnit == null)
         {
            leftUnit = new ActivityLeftUnitView(type);
            leftUnit.addEventListener("selected_change",refreshView);
            _vbox.addChild(leftUnit);
            _unitList.push(leftUnit);
         }
         setBgHeight(leftUnit);
         leftUnit.setData(arr,_rightFun);
         _vbox.refreshChildPos();
      }
      
      private function setBgHeight(leftUnit:ActivityLeftUnitView) : void
      {
         if(isNewServerExist)
         {
            leftUnit.bg.height = 300;
            leftUnit.list.height = 280;
         }
         else
         {
            leftUnit.bg.height = 360;
            leftUnit.list.height = 340;
         }
      }
      
      public function checkNewServerExist() : void
      {
         var i:int = 0;
         var leftUnit:ActivityLeftUnitView = getLeftUnitView(3);
         if(!leftUnit)
         {
            return;
         }
         i = 0;
         while(i < _vbox.numChildren)
         {
            if(_vbox.getChildAt(i) == leftUnit)
            {
               _vbox.removeChildAt(i);
               _unitList[i].removeEventListener("selected_change",refreshView);
               _unitList.splice(_unitList.indexOf(_unitList[i]),1);
               ObjectUtils.disposeObject(leftUnit);
               leftUnit = null;
               break;
            }
            i++;
         }
         _vbox.refreshChildPos();
      }
      
      public function extendUnitView() : void
      {
         var k:int = 0;
         var i:int = 0;
         var j:int = 0;
         var tmp:* = 0;
         if(selectedUnitIndex < 0)
         {
            if(WonderfulActivityManager.Instance.isSkipFromHall)
            {
               for(k = 0; k <= _unitList.length - 1; )
               {
                  if(_unitList[k].type == WonderfulActivityManager.Instance.leftUnitViewType && _unitList[k].getModelSize() > 0)
                  {
                     tmp = k;
                     break;
                  }
                  tmp = 2;
                  k++;
               }
            }
            else
            {
               i = 0;
               while(i <= _unitList.length - 1)
               {
                  if(_unitList[i].getModelSize() > 0)
                  {
                     tmp = i;
                     break;
                  }
                  i++;
               }
            }
         }
         else
         {
            if(selectedUnitIndex > _unitList.length - 1)
            {
               selectedUnitIndex = 0;
            }
            tmp = int(selectedUnitIndex);
         }
         (_unitList[tmp] as ActivityLeftUnitView).extendSelecteTheFirst();
         for(j = 0; j <= _unitList.length - 1; )
         {
            if(j != tmp)
            {
               (_unitList[j] as ActivityLeftUnitView).unextendHandler();
            }
            j++;
         }
         _vbox.refreshChildPos();
      }
      
      private function getLeftUnitView(type:int) : ActivityLeftUnitView
      {
         var i:int = 0;
         for(i = 0; i <= _unitList.length - 1; )
         {
            if(type == _unitList[i].type)
            {
               return _unitList[i];
            }
            i++;
         }
         return null;
      }
      
      private function refreshView(event:WonderfulActivityEvent) : void
      {
         var i:int = 0;
         var selectedUnit:ActivityLeftUnitView = event.target as ActivityLeftUnitView;
         for(i = 0; i <= _unitList.length - 1; )
         {
            if(_unitList[i] == selectedUnit)
            {
               selectedUnitIndex = i;
            }
            else
            {
               _unitList[i].unextendHandler();
            }
            i++;
         }
         _vbox.arrange();
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         for(i = 0; i <= _unitList.length - 1; )
         {
            _unitList[i].removeEventListener("selected_change",refreshView);
            i++;
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
            for each(var view in _unitList)
            {
               ObjectUtils.disposeObject(view);
               view = null;
            }
         }
         _unitList = null;
      }
      
      public function get isNewServerExist() : Boolean
      {
         return _isNewServerExist;
      }
      
      public function set isNewServerExist(value:Boolean) : void
      {
         _isNewServerExist = value;
      }
   }
}
