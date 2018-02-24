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
      
      public function TaskProgressView(){super();}
      
      private function initView() : void{}
      
      public function refreshView() : void{}
      
      public function dispose() : void{}
      
      public function get info() : QuestInfo{return null;}
   }
}
