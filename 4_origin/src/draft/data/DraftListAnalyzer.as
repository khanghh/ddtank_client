package draft.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class DraftListAnalyzer extends DataAnalyzer
   {
       
      
      private var _draftInfoVec:Vector.<DraftModel>;
      
      public function DraftListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         _draftInfoVec = new Vector.<DraftModel>();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            DraftModel.Total = _loc3_.@total;
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new DraftModel();
               _loc5_.id = _loc4_[_loc6_].@ID;
               _loc5_.ticketNum = _loc4_[_loc6_].@Count;
               _loc5_.playerInfo.ID = _loc4_[_loc6_].@UserID;
               _loc5_.playerInfo.NickName = _loc4_[_loc6_].@NickName;
               _loc5_.playerInfo.Style = _loc4_[_loc6_].@Style;
               _loc2_ = _loc4_[_loc6_].@Color.split("#");
               _loc5_.playerInfo.Colors = _loc2_[0];
               _loc5_.playerInfo.Skin = _loc2_[1];
               _draftInfoVec.push(_loc5_);
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get draftInfoVec() : Vector.<DraftModel>
      {
         return _draftInfoVec;
      }
   }
}
