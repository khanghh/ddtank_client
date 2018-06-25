package hall.tasktrack
{
   import com.greensock.TweenLite;
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   
   public class HallTaskTrackMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _taskBtn:SimpleBitmapButton;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _curTaskBtn:SelectedButton;
      
      private var _canGetBtn:SelectedButton;
      
      private var _listView:HallTaskTrackListView;
      
      private var _canGetListView:HallTaskCanGetListView;
      
      private const moveOutDistance:int = -1;
      
      private const moveInDistance:int = 199;
      
      private var m_width:Number = 200;
      
      public function HallTaskTrackMainView(npcBtn:BaseButton)
      {
         super();
         UIModuleLoader.Instance.addUIModlue("quest");
         initView(npcBtn);
         initEvent();
         setInOutVisible(true);
         _btnGroup.selectIndex = 0;
         judgeSelectShow(null);
      }
      
      public function judgeSelectShow(event:Event) : void
      {
         if(_listView.isEmpty() && !_canGetListView.isEmpty())
         {
            _btnGroup.selectIndex = 1;
         }
         else if(!_listView.isEmpty() && _canGetListView.isEmpty())
         {
            _btnGroup.selectIndex = 0;
         }
         else if(_listView.isEmpty() && _canGetListView.isEmpty())
         {
            _btnGroup.selectIndex = 0;
         }
         else if(_listView.isNoMainTask() && !_canGetListView.isEmpty())
         {
            _btnGroup.selectIndex = 1;
         }
      }
      
      private function initView(npcBtn:BaseButton) : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.hall.taskTrack.viewBg");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.hall.taskTrack.viewBg2");
         _bg.visible = false;
         _bg2.visible = false;
         _taskBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.taskOpenBtn");
         _moveInBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.moveInBtn");
         _moveOutBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.moveOutBtn");
         _curTaskBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.curTaskBtn");
         _canGetBtn = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.canGetBtn");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_curTaskBtn);
         _btnGroup.addSelectItem(_canGetBtn);
         _listView = new HallTaskTrackListView();
         _listView.visible = false;
         _canGetListView = new HallTaskCanGetListView(npcBtn);
         _canGetListView.visible = false;
         addChild(_bg);
         addChild(_bg2);
         addChild(_taskBtn);
         addChild(_moveInBtn);
         addChild(_moveOutBtn);
         addChild(_curTaskBtn);
         addChild(_canGetBtn);
         addChild(_listView);
         addChild(_canGetListView);
      }
      
      private function initEvent() : void
      {
         _taskBtn.addEventListener("click",taskClickHandler,false,0,true);
         _moveInBtn.addEventListener("click",moveInClickHandler,false,0,true);
         _moveOutBtn.addEventListener("click",moveOutClickHandler,false,0,true);
         _btnGroup.addEventListener("change",__changeHandler,false,0,true);
         _curTaskBtn.addEventListener("click",__soundPlay,false,0,true);
         _canGetBtn.addEventListener("click",__soundPlay,false,0,true);
         _listView.addEventListener("change",judgeSelectShow,false,0,true);
         _canGetListView.addEventListener("change",judgeSelectShow,false,0,true);
      }
      
      private function __changeHandler(event:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _listView.visible = true;
               _canGetListView.visible = false;
               _bg.visible = true;
               _bg2.visible = false;
               break;
            case 1:
               _listView.visible = false;
               _canGetListView.visible = true;
               _bg.visible = false;
               _bg2.visible = true;
         }
      }
      
      private function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function taskClickHandler(event:MouseEvent) : void
      {
         TaskManager.instance.switchVisible();
      }
      
      public function moveInClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(true);
         TweenLite.to(this,0.5,{
            "x":StageReferance.stageWidth - 199,
            "onComplete":moveInComplete
         });
      }
      
      public function moveOutClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(false);
         TweenLite.to(this,0.5,{
            "x":StageReferance.stageWidth - -1,
            "onComplete":moveOutComplete
         });
      }
      
      public function moveInComplete() : void
      {
         this.x = StageReferance.defaultWidth - 199;
         this.y = 250;
         m_width = 200;
         StageResizeUtils.Instance.addAutoResize(this);
      }
      
      private function moveOutComplete() : void
      {
         this.x = StageReferance.defaultWidth - -1;
         this.y = 250;
         m_width = 1;
         StageResizeUtils.Instance.addAutoResize(this);
      }
      
      override public function get width() : Number
      {
         return m_width;
      }
      
      override public function get height() : Number
      {
         return 260;
      }
      
      private function setInOutVisible(isOut:Boolean) : void
      {
         _moveOutBtn.visible = isOut;
         _moveInBtn.visible = !isOut;
      }
      
      private function removeEvent() : void
      {
         _taskBtn.removeEventListener("click",taskClickHandler);
         _moveInBtn.removeEventListener("click",moveInClickHandler);
         _moveOutBtn.removeEventListener("click",moveOutClickHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _curTaskBtn.removeEventListener("click",__soundPlay);
         _canGetBtn.removeEventListener("click",__soundPlay);
         _listView.removeEventListener("change",judgeSelectShow);
         _canGetListView.removeEventListener("change",judgeSelectShow);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _bg2 = null;
         _taskBtn = null;
         _moveInBtn = null;
         _moveOutBtn = null;
         _btnGroup = null;
         _curTaskBtn = null;
         _canGetBtn = null;
         _listView = null;
         _canGetListView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
