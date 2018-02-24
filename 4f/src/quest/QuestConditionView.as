package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestCondition;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class QuestConditionView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _cond:QuestCondition;
      
      private var conditionText:FilterFrameText;
      
      private var statusText:FilterFrameText;
      
      public function QuestConditionView(param1:QuestCondition){super();}
      
      public function set status(param1:String) : void{}
      
      public function set text(param1:String) : void{}
      
      public function set isComplete(param1:Boolean) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
