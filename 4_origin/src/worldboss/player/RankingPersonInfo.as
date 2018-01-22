package worldboss.player
{
   public class RankingPersonInfo
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var _damage:int;
      
      private var _percentage:Number;
      
      public function RankingPersonInfo()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set damage(param1:int) : void
      {
         _damage = param1;
      }
      
      public function get damage() : int
      {
         return _damage;
      }
      
      public function set percentage(param1:Number) : void
      {
         _percentage = param1;
      }
      
      public function get percentage() : Number
      {
         return _percentage;
      }
      
      public function getPercentage(param1:Number) : String
      {
         return (_damage / param1 * 100).toString().substr(0,5) + "%";
      }
   }
}
