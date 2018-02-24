package draft.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class DraftListAnalyzer extends DataAnalyzer
   {
       
      
      private var _draftInfoVec:Vector.<DraftModel>;
      
      public function DraftListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get draftInfoVec() : Vector.<DraftModel>{return null;}
   }
}
