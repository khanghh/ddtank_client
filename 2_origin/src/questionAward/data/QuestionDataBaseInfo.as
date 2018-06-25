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
      
      public function addContent(data:String) : void
      {
         _content.push(data);
      }
      
      public function getContent() : Vector.<String>
      {
         return _content;
      }
      
      public function get isMultiSelect() : Boolean
      {
         return _isMultiSelect;
      }
      
      public function set isMultiSelect(value:Boolean) : void
      {
         _isMultiSelect = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get title() : String
      {
         return qid + "." + _title;
      }
      
      public function set title(value:String) : void
      {
         _title = value;
      }
      
      public function get qid() : int
      {
         return _qid;
      }
      
      public function set qid(value:int) : void
      {
         _qid = value;
      }
   }
}
