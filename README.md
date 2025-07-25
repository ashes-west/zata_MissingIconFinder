# Missing Icons Checker (VORP + oxmysql)

This script checks which items in the `items` database table are missing an associated icon (`.png`) in the inventory image folder (`html/img/items/`).


## 🔧 Requirements

- VORP framework, which includes
	- `oxmysql` installed and configured
	- `vorp_inventory` (or compatible inventory) with icon path `html/img/items/`
	- `items` database table with a column named `item`
	- RedM client with NUI enabled (for clipboard copy functionality)
	- VORP admin (for admin access control)


## 🧪 Usage

### Automatic on Server Start

When the resource starts, it automatically checks for missing icons. It logs the first 5 missing items and the total count to the server console.

### Manual via Command from Game Client (Vorp Admins Only)

In-game, run the following command:
`/copymissingicons`


## 💡 Notes

- Only `.png` files inside `html/img/items/` are considered valid icons. There are other ways to attach icon images to items. So there might be a couple of false positives for exotic setups.
