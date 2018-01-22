package quest
{
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestCateListView extends ScrollPanel
   {
      
      public static var MAX_LIST_LENGTH:int = 4;
       
      
      private var _content:VBox;
      
      private var _stripArr:Array;
      
      private var _currentStrip:TaskPannelStripView;
      
      public function QuestCateListView()
      {
         super();
         _stripArr = [];
         initView();
      }
      
      private function initView() : void
      {
      }
      
      public function set dataProvider(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(param1.length == 0)
         {
            return;
         }
         this.height = 0;
         clear();
         _content = new VBox();
         var _loc3_:Boolean = false;
         if(param1.length > QuestCateListView.MAX_LIST_LENGTH)
         {
            _loc3_ = true;
         }
         _loc4_ = 0;
         while(param1[_loc4_])
         {
            _loc2_ = new TaskPannelStripView(param1[_loc4_]);
            _loc2_.addEventListener("click",__onStripClicked);
            _content.addChild(_loc2_);
            _stripArr.push(_loc2_);
            _loc4_++;
         }
         setView(_content);
         dispatchEvent(new Event("change"));
      }
      
      public function active() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _stripArr;
         for each(var _loc1_ in _stripArr)
         {
            if(_loc1_.info == TaskManager.instance.selectedQuest)
            {
               gotoStrip(_loc1_);
               _loc1_.active();
               return;
            }
         }
         if(_stripArr[0])
         {
            gotoStrip(_stripArr[0]);
            _stripArr[0].active();
            return;
         }
      }
      
      private function gotoStrip(param1:TaskPannelStripView) : void
      {
         if(_currentStrip == param1)
         {
            return;
         }
         if(_currentStrip)
         {
            _currentStrip.deactive();
         }
         _currentStrip = param1;
         TaskManager.instance.jumpToQuest(_currentStrip.info);
         dispatchEvent(new Event("change"));
      }
      
      private function __onStripClicked(param1:MouseEvent) : void
      {
         gotoStrip(param1.target as TaskPannelStripView);
      }
      
      private function clear() : void
      {
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _stripArr;
         for each(var _loc1_ in _stripArr)
         {
            _loc1_.removeEventListener("click",__onStripClicked);
            _loc1_.dispose();
            _stripArr = [];
         }
      }
      
      override public function dispose() : void
      {
         clear();
         _currentStrip.dispose();
         _currentStrip = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
