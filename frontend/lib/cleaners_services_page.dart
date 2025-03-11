import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CleanersServicesPage extends StatefulWidget {
  const CleanersServicesPage({super.key});

  @override
  State<CleanersServicesPage> createState() => _CleanersServicesPageState();
}

class _CleanersServicesPageState extends State<CleanersServicesPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ServicesPage(),
    const ServicesPage(),
    const ServicesPage(),
    const ServicesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              extended: screenWidth > 800,
              backgroundColor: const Color(0xFF3B6F3F),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              minExtendedWidth: 200,
              leading: const SizedBox(height: 16),
              trailing: const Spacer(),
              labelType: screenWidth > 800 ? NavigationRailLabelType.none : NavigationRailLabelType.selected,
              selectedIconTheme: IconThemeData(
                color: const Color(0xFF3B6F3F),
              ),
              unselectedIconTheme: IconThemeData(
                color: const Color(0xFFE4E2E2).withOpacity(0.5),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home', 
                    style: TextStyle(color: Color(0xFFE4E2E2)),
                    textAlign: TextAlign.left,
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.cleaning_services_outlined),
                  selectedIcon: Icon(Icons.cleaning_services),
                  label: Text('Services', 
                    style: TextStyle(color: Color(0xFFE4E2E2)),
                    textAlign: TextAlign.left,
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: Text('Activity', 
                    style: TextStyle(color: Color(0xFFE4E2E2)),
                    textAlign: TextAlign.left,
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Profile', 
                    style: TextStyle(color: Color(0xFFE4E2E2)),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.cleaning_services_outlined),
                  selectedIcon: Icon(Icons.cleaning_services),
                  label: 'Services',
                ),
                NavigationDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: 'Activity',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
}

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  IconData _selectedIcon = Icons.cleaning_services;
  int? _longPressedIndex;

  final List<Map<String, dynamic>> _availableIcons = [
    {'icon': Icons.cleaning_services, 'label': 'Cleaning'},
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.business, 'label': 'Office'},
    {'icon': Icons.window, 'label': 'Window'},
    {'icon': Icons.kitchen, 'label': 'Kitchen'},
    {'icon': Icons.bathtub, 'label': 'Bathroom'},
    {'icon': Icons.home_work, 'label': 'Move-in/out'},
    {'icon': Icons.local_laundry_service, 'label': 'Laundry'},
  ];
  
  List<Service> services = [
    Service(
      name: 'Home Cleaning',
      icon: Icons.home,
      description: 'Complete home cleaning service including dusting, vacuuming, and bathroom cleaning',
      price: 'From \$50/hour',
    ),
    Service(
      name: 'Deep Cleaning',
      icon: Icons.cleaning_services,
      description: 'Thorough deep cleaning service including windows, baseboards, and hard-to-reach areas',
      price: 'From \$150',
    ),
    Service(
      name: 'Office Cleaning',
      icon: Icons.business,
      description: 'Professional office cleaning service for your workplace',
      price: 'From \$80/hour',
    ),
    Service(
      name: 'Window Cleaning',
      icon: Icons.window,
      description: 'Interior and exterior window cleaning service',
      price: 'From \$40',
    ),
    Service(
      name: 'Carpet Cleaning',
      icon: Icons.cleaning_services,
      description: 'Deep carpet cleaning and stain removal service',
      price: 'From \$60',
    ),
    Service(
      name: 'Kitchen Cleaning',
      icon: Icons.kitchen,
      description: 'Specialized kitchen cleaning including appliances and cabinets',
      price: 'From \$70',
    ),
    Service(
      name: 'Bathroom Cleaning',
      icon: Icons.bathtub,
      description: 'Thorough bathroom cleaning and sanitization',
      price: 'From \$45',
    ),
    Service(
      name: 'Move-in/Move-out',
      icon: Icons.home_work,
      description: 'Complete cleaning service for moving in or out of a property',
      price: 'From \$200',
    ),
  ];

  List<Service> get filteredServices {
    if (_searchController.text.isEmpty) return services;
    return services
        .where((service) =>
            service.name.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();
  }

  void _deleteService(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Service'),
          content: Text('Are you sure you want to delete "${services[index].name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  services.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _addNewService() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _selectedIcon = Icons.cleaning_services;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Add New Service'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Select Icon', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableIcons.map((iconData) {
                        return InkWell(
                          onTap: () {
                            setDialogState(() {
                              _selectedIcon = iconData['icon'];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _selectedIcon == iconData['icon']
                                  ? const Color(0xFF3B6F3F).withOpacity(0.1)
                                  : null,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _selectedIcon == iconData['icon']
                                    ? const Color(0xFF3B6F3F)
                                    : Colors.grey,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  iconData['icon'],
                                  color: const Color(0xFF3B6F3F),
                                  size: 24,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  iconData['label'],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Service Name',
                        hintText: 'Enter service name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter service description',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        hintText: 'Enter price (e.g., From \$50/hour)',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty) {
                      setState(() {
                        services.add(
                          Service(
                            name: _nameController.text,
                            icon: _selectedIcon,
                            description: _descriptionController.text,
                            price: _priceController.text,
                          ),
                        );
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cleaning Services'),
        backgroundColor: const Color(0xFF3B6F3F),
        foregroundColor: const Color(0xFFE4E2E2),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFF3B6F3F),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search cleaning services...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFFE4E2E2)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE4E2E2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE4E2E2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE4E2E2), width: 2),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE4E2E2).withOpacity(0.2),
                    ),
                    style: const TextStyle(color: Color(0xFFE4E2E2)),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _addNewService,
                  icon: const Icon(Icons.add_circle, color: Color(0xFFE4E2E2)),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFE4E2E2).withOpacity(0.2),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 2,
                childAspectRatio: isDesktop ? 0.85 : 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredServices.length + 1,
              itemBuilder: (context, index) {
                if (index == filteredServices.length) {
                  return _buildAddCard();
                }
                return _buildServiceCard(
                  filteredServices[index],
                  index,
                  isLarge: isDesktop && index < 3,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCard() {
    return Card(
      child: InkWell(
        onTap: _addNewService,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 48,
                color: const Color(0xFF3B6F3F),
              ),
              const SizedBox(height: 8),
              Text(
                'Add New Service',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3B6F3F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(Service service, int index, {required bool isLarge}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;
    
    return Card(
      child: InkWell(
        onTap: () {
          // Handle service tap
        },
        onLongPress: () {
          setState(() {
            _longPressedIndex = index;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete Service'),
                content: Text('Are you sure you want to delete "${service.name}"?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _longPressedIndex = null;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        services.removeWhere((s) => s.name == service.name);
                        _longPressedIndex = null;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            },
          ).then((_) {
            setState(() {
              _longPressedIndex = null;
            });
          });
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(isLarge ? 24.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(isLarge ? 12.0 : 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B6F3F).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      service.icon,
                      size: isLarge ? 48 : 32,
                      color: const Color(0xFF3B6F3F),
                    ),
                  ),
                  SizedBox(height: isLarge ? 16.0 : 8.0),
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: isLarge ? 20 : 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF292828),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isLarge ? 8.0 : 4.0),
                  Expanded(
                    child: Text(
                      service.description,
                      style: TextStyle(
                        fontSize: isLarge ? 15 : 13,
                        color: const Color(0xFF4A4A4A),
                        height: 1.3,
                      ),
                      maxLines: isLarge ? 6 : 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: isLarge ? 16.0 : 8.0),
                  Text(
                    service.price,
                    style: TextStyle(
                      fontSize: isLarge ? 16 : 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B6F3F),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if ((isDesktop || _longPressedIndex == index))
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _deleteService(index),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}

class Service {
  final String name;
  final IconData icon;
  final String description;
  final String price;

  Service({
    required this.name,
    required this.icon,
    required this.description,
    required this.price,
  });
} 