package ddt.data.quest
{
   public class QuestCondition
   {
       
      
      private var _description:String;
      
      private var _type:int;
      
      private var _param1:int;
      
      private var _param2:int;
      
      private var _questId:int;
      
      private var _conId:int;
      
      private var _turnType:int;
      
      public var isOpitional:Boolean;
      
      public function QuestCondition(questId:int, conId:int, type:int, desc:String = "", para1:int = 0, para2:int = 0, turnType:int = 0)
      {
         super();
         _questId = questId;
         _conId = conId;
         _description = desc;
         _type = type;
         _param1 = para1;
         _param2 = para2;
         _turnType = turnType;
      }
      
      public function get target() : int
      {
         if(_type == 20 && _param1 != 3)
         {
            if(!_param2)
            {
               return 0;
            }
         }
         return _param2;
      }
      
      public function get param() : int
      {
         if(!_param1)
         {
            return 0;
         }
         return _param1;
      }
      
      public function get param2() : int
      {
         if(!_param2)
         {
            return 0;
         }
         return _param2;
      }
      
      public function get description() : String
      {
         if(_description == "")
         {
            return "no description";
         }
         return _description;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function tos() : String
      {
         return _description;
      }
      
      public function get questID() : int
      {
         return _questId;
      }
      
      public function get ConID() : int
      {
         return _conId;
      }
      
      public function get turnType() : int
      {
         return _turnType;
      }
   }
}
