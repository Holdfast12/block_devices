
1. Запустить первый раз vagrant up завершится с ошибкой SATA controller уже существует
2. Запустить второй раз vagrant up. Будут созданы контроллеры и диски. Диски будут присоеденены к контроллерам.
3. (ДЗ)В Vagrantfile: увеличил количество sata дисков с 6 до 10 и nvme с 4 до 6, убрал настройку private_network(vagrant ругался на адрес),прописал файл провижн-скрипта script.sh
4. (ДЗ)В script.sh: собирается RAID10, создается GPT раздел и 5 партиций, для первого доп.задания разделы форматируются и прописываются в /etc/fstab для монтирования при загрузке системы, монтируются
