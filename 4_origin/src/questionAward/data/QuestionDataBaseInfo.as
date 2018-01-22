package questionAward.data
{
   public class QuestionDataBaseInfo
   {
       
      
      private var _qid:int;
      
      private var _title:String;
      
      private var _type:int;
      
      private var _isMultiSelect:Boolean;
      
      private var _content:Vector.<String>;
      
      public function QuestionDataBaseInfo()
      {
         super();
         _content = new Vector.<String>();
      }
      
      public function addContent(param1:String) : void
      {
         _content.push(param1);
      }
      
      public function getContent() : Vector.<String>
      {
         return _content;
      }
      
      public function get isMultiSelect() : Boolean
      {
         return _isMultiSelect;
      }
      
      public function set isMultiSelect(param1:Boolean) : void
      {
         _isMultiSelect = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get title() : String
      {
         return qid + "." + _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function get qid() : int
      {
         return _qid;
      }
      
      public function set qid(param1:int) : void
      {
         _qid = param1;
      }
   }
}
