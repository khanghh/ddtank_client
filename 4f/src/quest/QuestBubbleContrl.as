package quest
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   
   public class QuestBubbleContrl
   {
      
      private static var _instance:QuestBubbleContrl;
       
      
      private var _view:QuestBubble;
      
      private var _model:QuestBubbleMode;
      
      public function QuestBubbleContrl(){super();}
      
      public static function get instance() : QuestBubbleContrl{return null;}
      
      public function setup() : void{}
      
      private function __questBubbleShowHandler(param1:Event) : void{}
      
      private function __questBubbleHideHandler(param1:Event) : void{}
   }
}
