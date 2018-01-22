package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import email.MailManager;
   import flash.utils.describeType;
   import road7th.utils.DateUtils;
   
   public class AllEmailAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function AllEmailAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc11_:int = 0;
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         _list = [];
         var _loc6_:XML = new XML(param1);
         if(_loc6_.@value == "true")
         {
            MailManager.Instance.Model.lastTime = _loc6_.@Time;
            _loc8_ = _loc6_.Item;
            _loc7_ = describeType(new EmailInfo());
            _loc2_ = describeType(new InventoryItemInfo());
            _loc11_ = 0;
            while(_loc11_ < _loc8_.length())
            {
               _loc10_ = new EmailInfo();
               ObjectUtils.copyPorpertiesByXML(_loc10_,_loc8_[_loc11_]);
               _loc5_ = _loc8_[_loc11_].Item;
               _loc9_ = 0;
               while(_loc9_ < _loc5_.length())
               {
                  _loc4_ = new InventoryItemInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc4_,_loc5_[_loc9_]);
                  _loc3_ = ItemManager.fill(_loc4_);
                  _loc10_["Annex" + getAnnexPos(_loc10_,_loc4_)] = _loc4_;
                  _loc4_.isGold = _loc5_[_loc9_].@IsGold == "true"?true:false;
                  _loc4_.goldBeginTime = String(_loc5_[_loc9_].@GoldBeginTime);
                  _loc4_.goldValidDate = int(_loc5_[_loc9_].@GoldVaild);
                  _loc4_.latentEnergyCurStr = String(_loc5_[_loc9_].@AvatarPotentialProperty);
                  _loc4_.latentEnergyEndTime = DateUtils.getDateByStr(String(_loc5_[_loc9_].@AvatarRemoveDate));
                  _loc4_.MagicAttack = int(_loc5_[_loc9_].@MagicAttack);
                  _loc4_.MagicDefence = int(_loc5_[_loc9_].@MagicDefence);
                  _loc4_.MagicLevel = int(_loc5_[_loc9_].@MagicLevel);
                  _loc10_.UserID = _loc3_.UserID;
                  _loc9_++;
               }
               if(!SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID] || SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID].indexOf(_loc10_.ID) < 0)
               {
                  _list.push(_loc10_);
               }
               _loc11_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc6_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get list() : Array
      {
         _list.reverse();
         return _list;
      }
      
      private function getAnnexPos(param1:EmailInfo, param2:InventoryItemInfo) : int
      {
         var _loc3_:* = 0;
         _loc3_ = uint(1);
         while(_loc3_ <= 5)
         {
            if(param1["Annex" + _loc3_ + "ID"] == param2.ItemID)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 1;
      }
   }
}
