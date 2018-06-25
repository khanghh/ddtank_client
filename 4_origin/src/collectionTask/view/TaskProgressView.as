package collectionTask.view
{
   import collectionTask.CollectionTaskManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TaskProgressView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _infoBtn:SimpleBitmapButton;
      
      private var _title:FilterFrameText;
      
      private var _progressTxtArr:Array;
      
      private var _progressDescArr:Array;
      
      private var _info:QuestInfo;
      
      private const CONDITION_ID:int = 64;
      
      public function TaskProgressView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var progressItem:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("collectionTask.infoBgAsset");
         addChild(_bg);
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("collectionTask.infoViewButton");
         _infoBtn.mouseEnabled = false;
         addChild(_infoBtn);
         _title = ComponentFactory.Instance.creatComponentByStylename("collectionTask.title1Txt");
         addChild(_title);
         _info = CollectionTaskManager.Instance.questInfo;
         _title.text = _info.Title;
         _progressTxtArr = [];
         _progressDescArr = _info.conditionProgress;
         for(i = 0; i < _progressDescArr.length; )
         {
            progressItem = new TaskProgressItem();
            addChild(progressItem);
            progressItem.x = 27;
            progressItem.y = 15 + 29 * (i + 1);
            _progressTxtArr.push(progressItem);
            i++;
         }
      }
      
      public function refreshView() : void
      {
         var i:int = 0;
         _progressDescArr = _info.conditionProgress;
         for(i = 0; i < _progressTxtArr.length; )
         {
            (_progressTxtArr[i] as TaskProgressItem).refresh(_progressDescArr[i]);
            i++;
         }
         CollectionTaskManager.Instance.isTaskComplete = _info.isCompleted;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         var _loc3_:int = 0;
         var _loc2_:* = _progressTxtArr;
         for each(var item in _progressTxtArr)
         {
            ObjectUtils.disposeObject(item);
            item = null;
         }
         _progressTxtArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get info() : QuestInfo
      {
         return _info;
      }
   }
}
