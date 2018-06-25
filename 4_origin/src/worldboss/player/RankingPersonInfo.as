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
      
      public function set id(value:int) : void
      {
         _id = value;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set damage(value:int) : void
      {
         _damage = value;
      }
      
      public function get damage() : int
      {
         return _damage;
      }
      
      public function set percentage(value:Number) : void
      {
         _percentage = value;
      }
      
      public function get percentage() : Number
      {
         return _percentage;
      }
      
      public function getPercentage(num:Number) : String
      {
         return (_damage / num * 100).toString().substr(0,5) + "%";
      }
   }
}
