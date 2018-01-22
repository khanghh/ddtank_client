package character.action
{
   public class ComplexBitmapAction extends BaseAction
   {
       
      
      private var _assets:Vector.<FrameByFrameItem>;
      
      private var _index:int;
      
      public function ComplexBitmapAction(param1:Vector.<FrameByFrameItem>, param2:String = "", param3:String = "", param4:uint = 0, param5:Boolean = false)
      {
         var _loc6_:FrameByFrameItem = null;
         super(param2,param3,param4,param5);
         _type = BaseAction.COMPLEX_ACTION;
         this._assets = param1;
         for each(_loc6_ in this._assets)
         {
            _len = Math.max(_len,_loc6_.totalFrames);
         }
         this._index = 0;
      }
      
      override public function get len() : int
      {
         return _len;
      }
      
      override public function reset() : void
      {
         var _loc1_:FrameByFrameItem = null;
         for each(_loc1_ in this._assets)
         {
            _loc1_.reset();
         }
         this._index = 0;
      }
      
      public function update() : void
      {
         this._index++;
      }
      
      override public function dispose() : void
      {
         this._assets = null;
         super.dispose();
      }
      
      override public function get isEnd() : Boolean
      {
         return this._index >= _len - 1;
      }
      
      public function get assets() : Vector.<FrameByFrameItem>
      {
         return this._assets;
      }
      
      override public function toXml() : XML
      {
         var _loc3_:FrameByFrameItem = null;
         var _loc1_:XML = super.toXml();
         var _loc2_:int = 0;
         while(_loc2_ < this._assets.length)
         {
            _loc3_ = this._assets[_loc2_];
            _loc1_.appendChild(_loc3_.toXml());
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
