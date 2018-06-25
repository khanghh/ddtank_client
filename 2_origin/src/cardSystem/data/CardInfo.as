package cardSystem.data
{
   import cardSystem.CardManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   
   public class CardInfo extends EventDispatcher
   {
      
      public static const WEAPON_CARDS:int = 1;
      
      public static const MONSTER_CARDS:int = 2;
      
      public static const cardsType:Array = [LanguageMgr.GetTranslation("BrowseLeftMenuView.equipCard"),LanguageMgr.GetTranslation("BrowseLeftMenuView.freakCard")];
      
      public static const cardsMain:Array = [LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.vice"),LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.main")];
      
      public static const MAX_EQUIP_CARDS:int = 4;
       
      
      public var CardID:int;
      
      public var UserID:int;
      
      public var TemplateID:int;
      
      public var Place:int;
      
      public var Count:int;
      
      public var CardType:int;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var Agility:int;
      
      public var Luck:int;
      
      public var Guard:int;
      
      public var Damage:int;
      
      public var Level:int;
      
      public var CardGP:int;
      
      public var isFirstGet:Boolean = true;
      
      public function CardInfo(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function get templateInfo() : ItemTemplateInfo
      {
         return ItemManager.Instance.getTemplateById(TemplateID);
      }
      
      public function get realAttack() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + CardManager.Instance.model.propIncreaseDic[TemplateID][i].Attack;
               i++;
            }
            return templateInfo.Attack + increate;
         }
         return templateInfo.Attack;
      }
      
      public function get realDefence() : int
      {
         var increate:int = 0;
         var dic:* = null;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            dic = CardManager.Instance.model.propIncreaseDic[TemplateID];
            for(i = 1; i <= Level; )
            {
               increate = increate + dic[i].Defend;
               i++;
            }
            return templateInfo.Defence + increate;
         }
         return templateInfo.Defence;
      }
      
      public function get realAgility() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + CardManager.Instance.model.propIncreaseDic[TemplateID][i].Agility;
               i++;
            }
            return templateInfo.Agility + increate;
         }
         return templateInfo.Agility;
      }
      
      public function get realLuck() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + CardManager.Instance.model.propIncreaseDic[TemplateID][i].Lucky;
               i++;
            }
            return templateInfo.Luck + increate;
         }
         return templateInfo.Luck;
      }
      
      public function get realDamage() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + CardManager.Instance.model.propIncreaseDic[TemplateID][i].Damage;
               i++;
            }
            return int(templateInfo.Property4) + increate;
         }
         return int(templateInfo.Property4);
      }
      
      public function get realGuard() : int
      {
         var increate:int = 0;
         var i:int = 0;
         if(Level != 0)
         {
            increate = 0;
            for(i = 1; i <= Level; )
            {
               increate = increate + CardManager.Instance.model.propIncreaseDic[TemplateID][i].Guard;
               i++;
            }
            return int(templateInfo.Property5) + increate;
         }
         return int(templateInfo.Property5);
      }
   }
}
