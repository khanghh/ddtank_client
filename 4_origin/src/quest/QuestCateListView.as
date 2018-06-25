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
      
      public function set dataProvider(value:Array) : void
      {
         var i:int = 0;
         var item:* = null;
         if(value.length == 0)
         {
            return;
         }
         this.height = 0;
         clear();
         _content = new VBox();
         var needScrollBar:Boolean = false;
         if(value.length > QuestCateListView.MAX_LIST_LENGTH)
         {
            needScrollBar = true;
         }
         i = 0;
         while(value[i])
         {
            item = new TaskPannelStripView(value[i]);
            item.addEventListener("click",__onStripClicked);
            _content.addChild(item);
            _stripArr.push(item);
            i++;
         }
         setView(_content);
         dispatchEvent(new Event("change"));
      }
      
      public function active() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _stripArr;
         for each(var strip in _stripArr)
         {
            if(strip.info == TaskManager.instance.selectedQuest)
            {
               gotoStrip(strip);
               strip.active();
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
      
      private function gotoStrip(strip:TaskPannelStripView) : void
      {
         if(_currentStrip == strip)
         {
            return;
         }
         if(_currentStrip)
         {
            _currentStrip.deactive();
         }
         _currentStrip = strip;
         TaskManager.instance.jumpToQuest(_currentStrip.info);
         dispatchEvent(new Event("change"));
      }
      
      private function __onStripClicked(e:MouseEvent) : void
      {
         gotoStrip(e.target as TaskPannelStripView);
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
         for each(var strip in _stripArr)
         {
            strip.removeEventListener("click",__onStripClicked);
            strip.dispose();
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
