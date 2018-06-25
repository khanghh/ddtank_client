package hall.tasktrack
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class HallTaskCanGetListView extends Sprite implements Disposeable
   {
       
      
      private var _titleTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _sprite:Sprite;
      
      private var _dataList:DictionaryData;
      
      private var _npcBtn:BaseButton;
      
      private var _pointDownArrow:MovieClip;
      
      public function HallTaskCanGetListView(npcBtn:BaseButton)
      {
         super();
         this.mouseEnabled = false;
         _npcBtn = npcBtn;
         _dataList = TaskManager.instance.manuGetList;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellConditionTxt");
         _titleTxt.width = 300;
         _titleTxt.htmlText = LanguageMgr.GetTranslation("hall.taskCanGetListView.titleTxt");
         _titleTxt.mouseEnabled = true;
         _titleTxt.x = 7;
         _titleTxt.y = 10;
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("hall.taskCanGetListView.scrollPanel");
         _sprite = new Sprite();
         addChild(_titleTxt);
         addChild(_scrollPanel);
      }
      
      private function initEvent() : void
      {
         _titleTxt.addEventListener("link",textClickHandler);
         _dataList.addEventListener("add",addHandler);
         _dataList.addEventListener("remove",removeHandler);
      }
      
      private function addHandler(event:DictionaryEvent) : void
      {
         refreshView();
      }
      
      private function removeHandler(event:DictionaryEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var i:int = 0;
         var taskTitleTxt:* = null;
         ObjectUtils.disposeAllChildren(_sprite);
         var dataArray:Array = _dataList.list;
         var tmpLen:int = dataArray.length;
         if(tmpLen > 0)
         {
            for(i = 0; i < tmpLen; )
            {
               taskTitleTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.cellTitleTxt");
               taskTitleTxt.text = ">>" + dataArray[i].Title;
               taskTitleTxt.y = 20 * i;
               _sprite.addChild(taskTitleTxt);
               if(dataArray[i].QuestID == 558 && !_pointDownArrow)
               {
                  _pointDownArrow = ComponentFactory.Instance.creat("asset.newHandGuide.newArrowPointDown");
                  _pointDownArrow.mouseChildren = false;
                  _pointDownArrow.mouseEnabled = false;
                  _pointDownArrow.x = 43;
                  _pointDownArrow.y = -59;
                  addChild(_pointDownArrow);
               }
               i++;
            }
            _scrollPanel.setView(_sprite);
            _titleTxt.visible = true;
            _scrollPanel.visible = true;
         }
         else
         {
            _titleTxt.visible = false;
            _scrollPanel.visible = false;
            if(_pointDownArrow)
            {
               _pointDownArrow.gotoAndStop(1);
               removeChild(_pointDownArrow);
               _pointDownArrow = null;
            }
         }
         dispatchEvent(new Event("change"));
      }
      
      private function textClickHandler(event:TextEvent) : void
      {
         _npcBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      public function isEmpty() : Boolean
      {
         return _dataList.length <= 0;
      }
      
      private function removeEvent() : void
      {
         _titleTxt.removeEventListener("link",textClickHandler);
         _dataList.removeEventListener("add",addHandler);
         _dataList.removeEventListener("remove",removeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_pointDownArrow)
         {
            _pointDownArrow.gotoAndStop(1);
            removeChild(_pointDownArrow);
            _pointDownArrow = null;
         }
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeAllChildren(_sprite);
         _titleTxt = null;
         _scrollPanel = null;
         _sprite = null;
         _dataList = null;
         _npcBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
